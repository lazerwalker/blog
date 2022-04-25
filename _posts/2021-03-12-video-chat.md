---
layout: post
title: "Why Video Chat is a Hard Technical Problem"
date: 2021-03-12 12:00
comments: true
---

Back over the summer, I began a series of experiments to play around with new forms of synchronous online social interaction while we're all stuck at home. These ranged from a [virtual conference hosted in a custom text-based MMORPG](https://blog.lazerwalker.com/2020/10/22/virtual-events-and-game-design.html) to using real-time mocap in the browser to make 2D animated avatars:

<center style="margin: 2em">
<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I&#39;ve been (slowly) prototyping new tools to foster online social interaction, and while it&#39;s too early to say if there&#39;s anything here, I&#39;m pretty excited about my latest prototype. <a href="https://t.co/IZFAJatKmg">pic.twitter.com/IZFAJatKmg</a></p>&mdash; emilia ✨ (@lazerwalker) <a href="https://twitter.com/lazerwalker/status/1272894598214492160?ref_src=twsrc%5Etfw">June 16, 2020</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
</center>

For these early experiments, I used [WebRTC](https://webrtc.org/), a browser-based peer-to-peer videochat technology. Since I was churning out small experiments quickly, I cared about being able to build something as quickly as possible, and ideally without having to spin up complicated and/or expensive servers.

WebRTC sounds like it's perfect for this! Being peer-to-peer means you don't need complicated or expensive server infrastructure, and being a well-supported piece of browser tech means there are a lot of educational resources out there.

To jump straight to the punchline: after we built a WebRTC-based videochat service for [Roguelike Celebration](https://roguelike.club)'s event platform, we ripped it out and replaced it with a series of Zoom links for the actual event. Our WebRTC setup simply wasn't viable for production use. 


I've since talked to many other folks who built out WebRTC setups, ranging from simple to complex, and similarly ran into unacceptable performance pitfalls. This doesn't mean that WebRTC as a technology isn't viable for things like this — all of the solutions I recommend later in this article ultimately still use WebRTC under the hood — but reality is significantly more complicated than just reading the WebRTC API spec and building against it.

The rest of this article will walk you through our learning process, and what we learned is necessary to make a WebRTC videochat setup work in a production environment. Our path to functioning videochat was long and winding; I want to outline what we learned to save other people from spending the same time and effort we did to come to that understanding.


## Problem 1: Accessing AV Hardware
Before we even get to sending audio and video streams over a network, we need audio and video streams. This means using the browser [MediaDevices](https://developer.mozilla.org/en-US/docs/Web/API/MediaDevices) API, not yet WebRTC. But this has a catch!

The API is simple. You call `navigator.mediaDevices.getUserMedia()` and get access to audio and video streams. The catch: the user doesn't get to specify which specific input devices they want to use, so someone with multiple microphones or webcams is going to have a hard time. You'd assume web browsers would provide their own UIs to let users select devices, but the reality is complicated.

If someone is using Firefox, they will in fact get a nice friendly popup asking which audio and video input they want to use. If they're using Chrome, that option is hidden deep in a settings menu, and it's extraordinarily bad at remembering your preferences. That UI doesn't exist at all anywhere in Safari.

**Solution**: building a production-ready app means you'll need to **build your own in-app device selector** for available audio and video inputs. 

This is doable, but a pain. You also have to deal with inconsistencies in the ways different browsers surface the MediaDevices APIs for accessing that data. Ideally, you're using some sort of persistent local storage (e.g. the localStorage API) so you can remember the user's preference and not make them navigate a dropdown every single time they enter a chat.


## Problem 2: Making a connection

Okay, so you've got proper audio and video streams, coming from the correct local input devices. Now we need a way to send that to other users!

The most straight-forward way to do a group videochat in WebRTC is using what's called a full-mesh network topology. This sounds complicated, but it just means "every client is connected to every other client". If there are 3 of us in a chat, each of our web browsers has a direct connection to each of the other two people's web browsers, and a new person joining would immediately initiate three new connections to each of us.

To open a WebRTC connection between two clients, one client generates an offer. The other client accepts that offer and generates a response. The initiating client accepts that response, and you're off to the races.

To send these offers and responses back and forth between clients, you need some sort of data transport mechanism. And since you don't yet have a WebRTC data connection you can use, this means you'll need some sort of server infrastructure. Building and scaling a backend to exchange handshake strings between clients is a lot less work than building one to send video data, but it's not nothing. 

**Solution:** You'll need to **build your own server backend** that can transport strings between clients until they successfully open a peer-to-peer connection.

WebSockets are a great choice for this, but WebSockets are also a pain to scale compared to regular HTTP servers. I personally use a combination of [Azure Functions](https://docs.microsoft.com/azure/azure-functions/functions-overview?WT.mc_id=spatial-6379-emwalker) and [Azure SignalR Service](https://docs.microsoft.com/azure/azure-signalr/signalr-overview?WT.mc_id=spatial-6379-emwalker) to do this handshake (in an architecture similar to what I outline in [this article](https://blog.lazerwalker.com/2020/11/20/serverless-virtual-worlds.html)), but this still requires maintaining server-side services!

## Problem 3: What if network settings mean clients can't connect?

Let's say you've built out a simple WebRTC flow, where 4 different people are all connected to each other. This means there'll be 6 different WebRTC connections across all participants. You'll quickly find something pretty weird: chances are, at least one of those 6 connections will fail and two people won't be able to videochat with each other.

The short explanation for this is router settings. After the WebRTC signaling handshake is complete, a remote service called ICE tries to directly connect the two clients by getting publicly-accessible IP addresses for both. 

An ICE service will first try to use a STUN server, which is a server that basically exists to tell a client what its public IP address is. In the ideal case, this just works to give you working IP addresses for both clients, and you're done.

If one or both clients are behind a particularly protective NAT layer (e.g. due to a corporate firewall), that STUN public IP dance isn't going to work. In that case, both clients need to connect to a relay, called a TURN server, that forwards all messages between the two since they can't connect directly.

If you're interested in a more detailed technical explanation for this issue, [this article](https://www.html5rocks.com/en/tutorials/webrtc/infrastructure/#after-signaling-using-ice-to-cope-with-nats-and-firewalls) is a great resource.

Conventional wisdom says that about 80% of WebRTC connections will succeed with only STUN. This means that, unless you have a TURN server to fall back to, about 20% of all connections will fail!

**Solution**: Run your own **TURN relay server** for when clients' NAT settings don't allow them to connect directly.

STUN services are cheap to run, and it's pretty easy to find free ones that can scale with your prototype. Since TURN servers are more resource-intensive (given they're active beyond just the handshake stage of a connection), you'll probably need to host your own rather than find free community options.

One option is to use [Twilio's hosted TURN service](https://www.twilio.com/stun-turn). Another is to [host your own Docker image on a cloud provider such as Azure](https://devblogs.microsoft.com/cse/2018/01/29/orchestrating-turn-servers-cloud-deployment/?WT.mc_id=spatial-6379-emwalker).


## Problem 4: What if too many people are connected?

At this point, you've got a working videochat app. You've built your own AV selector UI to let people pick their devices. You've built server infrastructure to let clients complete offer handshakes. You're running a TURN server to make sure that everyone can connect regardless of their network setup. This all sounds great.

And then, you try to have a videocall with more than 4 people and your computer comes to a grinding halt.

This "full-mesh" setup - where each person in a 4-person videochat is sending and receiving video data from each of the other three participants - is incredibly wasteful. 

For each additional participant, your own bandwidth and CPU/GPU consumption increase linearly. Even on a pretty beefy computer with a solid fast network connection, performance usually anecdotally starts degrading somewhere above 4-ish video participants or 10-ish audio-only participants. 

And that assumes a solid network connection. If one participant has slow Internet speeds, ideally other clients would start sending them a lower-bitrate video stream, but that sort of selective real-time transcoding really isn't feasible to do in the browser.

It's worth noting that this is not just a technical concern but an accessibility issue: by building a system that falls over unless you have a top-of-the-line computer and a blazing fast Internet connection, you're building a system that only serves the most privileged.

There's no clear fix here other than not having to send out your same audio/video stream N times and having to simultaneously decode and present N remote A/V streams.

**Solution**: Move away from a full-mesh peer-to-peer system in favor of a centralized system, most likely a **Selective Forwarding Unit** (SFU).

A SFU is a server that acts as a single WebRTC peer to send and receive video data. Instead of connecting to all of the other people using your chat app directly, your client just connects to the SFU and sends its A/V streams to that single source. The SFU selectively decides which other connected clients should receive a given audio or video stream, and can also intelligently do things such as dynamic video reencoding to serve lower-bitrate streams to clients with lower bandwidth caps.

There are many different ways to run a SFU, but one common way is integrating the [mediasoup](https://mediasoup.org/) library into your own Node.js server so you can configure and scale it exactly how you would like.

## ...but that's A LOT for just doing basic video chat!
I agree! My goal was initially to build some fun little prototypes of novel social interaction patterns, and instead I found myself deep in the technical weeds of networking protocols and peer-to-peer network topologies.

I hope this mile-high overview of the tricky bits of implementing WebRTC can at least get you to understand why this is a hard problem, and give you the lay of the land for coming up with your own solution.

In particular, I have two concrete recommendations:

1. If you're just experimenting, start out by using a fully-hosted video solution such as [Azure Communication Service](https://docs.microsoft.com/azure/communication-services/overview?WT.mc_id=spatial-6379-emwalker) or [Twilio Programmable Video](https://www.twilio.com/docs/video). You'll get an easy-to-integrate API that doesn't require running your own server backend, audio and video chat that automatically scales to any number of simultaneous users, and relatively minimal costs for prototype-scale use.

2. If you're building a production piece of software where video or audio chat will be a core component, a hosted solution is still the most effort-free option, but you may want to build your own solution to save costs and have more control over your infrastructure. If that's the case, jump straight to running your own SFU. Trying to just get by with a full-mesh topology and maybe a TURN server is ultimately not going to be good enough. Learn from the experiences of myself and countless others and save yourself the time and effort.

Has this helped? Come up with your own solution to recommend? Let me know on [Twitter](https://twitter.com/lazerwalker), I'm always happy to hear from more folks tackling these hard problems :)

