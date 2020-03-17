---
layout: post
title: "Making a weird GIF wall with Azure Functions and SignalR"
date: 2019-12-06 12:00
comments: true
categories: azure
---

At this year’s [XOXO festival](http://xoxofest.com), one of the top-secret closing party happenings was a special live listening of [Neil Cicerega](http://neilcic.com)'s latest mashup album. If you're not familiar with Neil's work, his previous album [Mouth Moods](http://www.neilcic.com/mouthmoods/) might give you an idea of what was played: a weird and surprising concept album that sort of amounts to cramming an excessive amount of Pure Internet™ into your ear through mashups, references, and very clever mixing.

One of the XOXO organizers approached [Reed Kavner](https://twitter.com/reedkavner) and I to make some sort of interactive installation to accompany the listening party: a sort of gif wall where listeners could post GIFs and other weird Internet ephemera as a way of annotating the piece.

I had just started my new job on the Microsoft [Azure Advocates](https://twitter.com/azureadvocates) team, so I took this as a chance to try out a whole bunch of Azure tech for the first time!

# A Wall of Pure Internet

[![Video of the wall in action](https://uploads.lazerwalker.com/xoxo-420p.gif)](https://uploads.lazerwalker.com/IMG_2162.MOV)

The goal was to create a completely overwhelming wall of GIFs and text. We wanted people to be able to live-annotate the music by pulling up memes the music itself was referencing, while itself playing into a sort of Internet-y vaporwave visual aesthetic.

We decided to rely on Slack rather than build out our own UI. XOXO has an active year-round Slack community, and most attendees were already logged into the festival Slack on their phones. This handled a whole bunch of hard problems for us: authentication, mapping posts to real names (important to handle Code of Conduct violations) and fully handling GIF search (including explicit content filters).

The level of trust we put in our community (along with our real-name policy) meant we could also allow people to post plaintext messages instead of just GIFs. Along with that, it mattered to us that we supported all of the custom emoji that our Slack supports, since the community has built up a large collection of meaningful ones.

One other conscious design decision was to not rate-limit how often anybody could post. When you post a GIF or some text, it shows up on screen and slowly grows over time, but any newer GIFs that come after yours will cover yours up. We simply set the starting size of a post based on how recently the author last posted. If somebody wanted to sit there and spam GIFs as quickly as they could, we wanted to let them do that, but making their content start smaller meant their fun wouldn't come at the expense of annoying others.

# Serverless? With a long-running client?!

While Reed built out the JS front-end (available on [GitHub](https://github.com/reedkavner/gif-viz)), I was responsible for the server infrastructure to send messages to a web browser.

I was interested in using [Azure Cloud Functions](https://azure.microsoft.com/en-us/services/functions/?WT.mc_id=personalblog-blog-emwalker) to avoid needing to spin up my own server on something like EC2 or Heroku. With "serverless" tools like Azure Cloud Functions, you just upload a single free-floating function (JS in my case), and instead of you maintaining a server runtime, Azure is responsible for spinning up an instance and running your function any time somebody hits a specified HTTP endpoint. In our case, that endpoint is a webhook being triggered by a Slack API app.

On the browser side, we assumed we'd use a WebSocket connection to send messages to the client. However, WebSockets require a long-living connection. With serverless functions, we only have an execution environment at the moment our function is being called, which makes it rather difficult for the browser app to have a persistent WS connection!

## Enter SignalR!

[SignalR](https://docs.microsoft.com/en-us/azure/azure-signalr/signalr-overview?WT.mc_id=personalblog-blog-emwalker) is a technology designed to make it easy for servers to broadcast real-time messages to various clients. It’s different from WebSockets in that it’s unidirectional — it can only be used to send messages from servers to clients, not the other way around.

It's mostly meant for larger, more enterprise-focused uses: it gracefully handles things that WebSockets doesn’t like more complex authentication and connection handshakes. It operates at a higher level of abstraction than WebSockets: by default, it even uses WebSockets in the browser as its transport mechanism, but can fall back to alternate methods automatically (e.g. polling) without you needing to worry about it as a developer.

We don't care about the security or reliability promises of SignalR, but we do care that Azure offers a hosted SignalR service that can interoperate with Azure Cloud Functions. This lets us overcome the issue of needing a long-running connection to a short-lived server!

![Architecture diagram](https://thepracticaldev.s3.amazonaws.com/i/rpg03awjwn36ok6akxgf.png)

The browser client connects to the Azure SignalR service, which maintains that connection for as long in the browser is open. In the meanwhile, any time an Azure Function instance spins up and executes, it can independently connect to the SignalR service and push messages to the queue. We get the flexibility of using serverless functions to build our node app, but can still maintain a long-running WebSocket connection to the client app. Neat!

## Using SignalR with Cloud Functions: Declaring Inputs and Outputs

I'm not going to explain in here how to get set up with Azure Functions — check out [this tutorial](https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-first-function-vs-code?WT.mc_id=devto-blog-emwalker) for getting started using the official [VS Code](https://code.visualstudio.com?WT.mc_id=personalblog-blog-emwalker) extension, which is by far the easiest way to manage the fiddly bits — but I do want to talk a bit about how I integrated SignalR with my cloud Function.

Azure Functions have a really elegant way of handling external dependencies into your code. An Azure Function is just a single file with a single code function, but accompanying it is a `function.json` config file that specifies all inputs and outputs the function accepts. Add a bunch of dependencies to your `function.json` file, and they'll automatically be injected into your function as arguments!

Setting up SignalR requires two different functions. First, there's a short setup handshake required: a browser that wants to connect to our SignalR instance needs to hit an HTTP endpoint that returns the magic connection string it needs to complete the connection

```json
{
  "disabled": false,
  "bindings": [
    {
      "authLevel": "anonymous",
      "type": "httpTrigger",
      "direction": "in",
      "name": "req"
    },
    {
      "type": "http",
      "direction": "out",
      "name": "res"
    },
    {
      "type": "signalRConnectionInfo",
      "name": "connectionInfo",
      "hubName": "chat",
      "direction": "in"
    }
  ]
}
```

```js
module.exports = async function(context, req, connectionInfo) {
  context.res.json(connectionInfo);
};
```

You can see here we're setting up a function that has standard ExpressJS request/response inputs/outputs, as well as an extra `connectionInfo` argument that we specify in our `function.json` file should contain SignalR connection info to a message queue called "chat".

Our actual "post a message" Slack webhook function has a slightly different `function.json` file, as it uses the SignalR connection as an output (essentially a message queue it pushes messages onto) rather than an input:

```js
{
  "disabled": false,
  "bindings": [{
      "authLevel": "anonymous",
      "type": "httpTrigger",
      "direction": "in",
      "name": "req",
      "methods": [
        "post"
      ]
    },
    {
      "type": "http",
      "direction": "out",
      "name": "res"
    },
    {
      "type": "signalR",
      "name": "$return",
      "hubName": "chat",
      "direction": "out"
    }
}
```

The `"name": "$return"` property means that whatever our function returns ends up getting pushed onto the `"chat"` SignalR queue as a message, which in turn gets pushed to all connected SignalR clients.

With these two functions in place, the actual client code to connect to the SignalR queue is fairly simple:

```js
const connection = new signalR.HubConnectionBuilder()
  .withUrl(`https://xoxo-closing-party.azurewebsites.net/api`)
  .configureLogging(signalR.LogLevel.Information)
  .build();

connection.on("newMessage", function(m) {
  addPost(m); // m is a JSON blob containing whatever our function sends
});

connection.onclose(() => console.log("disconnected"));

connection
  .start()
  .then(() => console.log("Connected!"))
  .catch(console.error);
```

You'll notice the SignalR library itself is responsible for hitting the handshake endpoint and then subscribing to new messages.

## Emojis are Hard!

With this code so far, my backend was sending messages to Reed's JS webapp containing message text and, if applicable, GIF data. But all emoji were coming through as Slack-style text shortnames. e.g. instead of the "🎉" emoji, the messages contained the string `:tada:`.

Fixing this actually meant handling two totally separate things: proper Unicode emoji, and our Slack instance's custom emoji set.

For “official” emoji, I was able to find someone else who already wrote a quick script to fetch Slack's mapping. This CLI one-liner I modified from the web gave me a JSON object mapping from short name to Unicode code point.

```bash
curl -s https://raw.githubusercontent.com/iamcal/emoji-data/master/emoji.json | \
  npx ramda-cli \
    'reject (.unified.includes("-"))' \
    'chain (emoji) -> emoji.short_names.map -> {...emoji, short_name: it}' \
    'sort-by (.short_name)' \
    'index-by (.short_name)' 'map -> "0x#{it.unified}"' > emoji.json
```

```json
{
  ...,
  "abacus": "0x1F9EE",
  "abc": "0x1F524",
  "abcd": "0x1F521",
  "accept": "0x1F251",
  "adult": "0x1F9D1",
  "aerial_tramway": "0x1F6A1",
  "airplane_arriving": "0x1F6EC",
  "airplane_departure": "0x1F6EB",
  "alarm_clock": "0x23F0",
  "alien": "0x1F47D",
  "ambulance": "0x1F691",
  "amphora": "0x1F3FA",
  "anchor": "0x2693",
  "angel": "0x1F47C",
  "anger": "0x1F4A2",
  "angry": "0x1F620",
  "anguished": "0x1F627",
  "ant": "0x1F41C",
  "apple": "0x1F34E",
  "aquarius": "0x2652",
  ...
}
```

From there, I was able to use built-in JS string replacement functions to replace all valid Unicode emoji with the proper Unicode code points:

```js
const replaceEmoji = message => {
  const standardEmojiMap = require("./emoji");
  return message.replace(/\:(.*?)\:/g, (original, name) => {
    if (standardEmojiMap[name]) {
      return String.fromCodePoint(standardEmojiMap[name]);
    } else {
      // This isn't in our list of Unicode emoji — either it's a custom emoji or nonsense
      return original;
    }
  });
};
```

Custom emoji were a bit trickier. Slack offers an [API endpoint](https://api.slack.com/methods/emoji.list) to grab the custom emoji for any given Slack instance.

Crucially, although it returns a map whose keys are emoji names, the values can be one of two things: a URL to a CDN-hosted image for that emoji, or the name of another emoji name that it's an alias for. So when doing my own find/replace, I needed to check if it was an alias, and if so make sure to resolve that. When I eventually landed on an actual URL, I replaced the `:emoji:` with an HTML `<img>` tag pointed at the CDN URL.

This made things slightly trickier for Reed: however he was rendering this text on-screen, he now needed to make sure that `<img>` tags were rendered properly as HTML, but also do that in a way where `<script>` tags wouldn't be executed as arbitrary JavaScript. It added some complexity, but we concluded that was easier than alternative methods of specifying "this image should be injected at this point within the text".

I cached this custom emoji data from Slack in an Azure CosmosDB database. While it's not like our custom emoji updated all that frequently, I needed to build out that caching infrastructure to handle fetching names as well.

Messages from Slack only contained unique user IDs, not human-readable names, so just like emoji I ended up needing to make some API calls to Slack's [user list](https://api.slack.com/methods/users.list) API endpoint so I could do my own lookup.

I'm not going to go into that process of using CosmosDB right now — our name cache (but not our emoji cache!) ended up falling over in production, and it was suggested to me after-the-fact that [Azure Table Storage](https://azure.microsoft.com/en-ca/services/storage/tables/?WT.mc_id=devto-blog-emwalker) would have been a better fit for our needs.

# The End-Result

...and that's (more or less) all there was to it! I glossed over a whole lot here, but you can check out the [GitHub repo](https://github.com/lazerwalker/xoxo-closing-party) to see the code itself. I was impressed how well Azure Functions and SignalR worked — messages came through within a second or two of people sending them, it scaled effortlessly even when we were getting hundreds of messages per minute, and everybody loved the installation!

I'd love to see someone else take our code (or just inspiration from us) and make something similar! Shout at me on [Twitter](https://twitter.com/lazerwalker) if you do anything cool like this.
