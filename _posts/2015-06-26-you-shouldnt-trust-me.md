---
layout: post
title: "You Shouldn't Trust Me"
date: 2015-06-26 9:20
comments: true
categories:
---

_This is part of a series of blog posts about my caffeine-tracking app [Cortado](https://itunes.apple.com/us/app/cortado/id969899327). For more information, check out the [first post in the series](http://blog.lazerwalker.com/2015/06/25/location-as-intent-introducing-cortado.html).)_

I just released an app called [Cortado](http://cortadoapp.com) to help you track your caffeine consumption. Rather than making you remember to manually open an app and check off every time you have a coffee, Cortado figures out when you go to a coffee shop and prompts you add your caffeine with a single tap right from your phone's lock screen.

I'm gonna be honest, though: you shouldn't trust me. You're placing your personal data squarely in the hands of some random guy on the Internet who built an app. A lot of the data you're willingly giving me – how much caffeine you consume, what coffee shops you frequent, what your favorite drinks are – is valuable to advertisers. If I don't do anything with that data, I'm probably leaving money on the table.

Sure, you might be saying, but Cortado costs money. Because my users are my customers, I shouldn't need to make money by selling data to third parties. Alright, sure. But $1.99 per app isn't a lot. And I'm a one-man shop. It's possible – likely, even – that I'm not handling your data as securely as I could be. Even if I don't explicitly sell your data, what's to say there isn't a glaring security vulnerability leaving your data open to plundering? Even if that's not the case, I'm probably relying on third-party services to do some of the heavy lifting; what's to say they don't have vulnerabilities, or that they're not sending your data straight to the NSA?

## What Cortado actually does with your data

I can tell you with confidence that I'm *not* actually selling your Cortado data to third parties. I'm not even storing it on the Internet where it could be open to attack. Cortado stores data in two places: a local cache of data inside the app's documents directory on your phone, and Apple HealthKit[^1]. I don't send your caffeine data to any remote server[^2]. 

I do currently use a third-party analytics service – Mixpanel – to track a few in-app events. I only track actions you take, not your specific user input associated with them – for example, I note that you added a drink, not what that drink was, where you were, or when you had it[^3]. Mixpanel stores your IP address and deduces your general location from that. It also stores a unique identifier that Apple provides, but that identifiers cannot be correlated or connected to any other app or a human. Cortado never asks for any sort of personally identifying login information, so there's no way to connect that random identifier to a person.

Most importantly, I actively plan to remove Mixpanel from future releases of the app. I have a few very specific hypotheses I want to test with the initial version of the app that require me to gather anonymized usage data en masse; once I have answers, out go the analytics.

## You *really* shouldn't trust me

I've just said a bunch of very nice words about how I respect your privacy. Awesome. Here's the problem: **you have no way of knowing that everything I just said isn't complete and utter bullshit.**

Truly dedicated privacy freaks might proxy their phone's network traffic through their computer and sniff all outgoing packets to see what data is being sent back to a server. For apps that do require server-side services, this isn't particularly helpful, since you can't see what the data is then used for. Even if it appears that the network traffic from a given app is all benign, it's not unreasonable to assume your data could be obfuscated somehow.

Is it even possible to be sure?

## The solution: Open Source 

If you open Cortado's settings/about page, you'll notice a curious menu item: "Source Code". That's right. Cortado is 100% open source. Tapping that link takes you to the GitHub tag representing the exact source code of the build you're currently running on your phone. You don't have to take my word for it when I say I don't send your data over the Internet; you can verify for yourself.

Of course, that assumes that the source code I link you to actually represents the code that compiled the binary you downloaded off the App Store. Unless you're going to compile your own version from source, it's hard to be sure of that. I'm working on it; it should be possible to strip the code-signing headers from a signed iOS binary in such a way that two binaries coming from the same source code, even if signed by different Apple Developer accounts, will yield the same hash.

## Have I lost it?

I consider the open-sourcing of Cortado to be one part experiment, one part political statement.

Cortado is a paid app. I would like very much to make a decent profit off of it to help support future development of it and future projects. But anyone with an Apple Developer Account can easily clone the repo, build it for their phone, and get the exact same application you can get on the App Store for free. Even worse, I've intentionally chosen to license it under a very permissive license (MIT), meaning there's nothing I could do if someone wanted to release a Cortado clone using its codebase. For all I know, this experiment could fail miserably. I'd like to think, perhaps over-idealistically, that people who derive value from Cortado will choose to pay. If not, I'll have learned a valuable lesson.

It's more important to me that we seriously think about our privacy, and what trust means in context of software that handles our personal data. We need to think about the repercussions of trusting large corporations that don't have our best interests at heart and have no incentives or obligations to be transparent. Sure, caffeine consumption is perhaps not the most sensitive information on the planet, and using iOS at all still requires placing a decent amount of trust in a closed-source system, but the low buy-in of Cortado is perhaps what makes it such a good testing ground. If Cortado's source being out in the open gets people thinking about what data transparency means in context of consumer applications, I'll consider this project a raging success.

So no, you still shouldn't trust me. But I've given you the right tools that you don't have to.

[^1]: The local cache is currently not encrypted or stored securely. That would be a sensible improvement.

[^2]: Technically, whenever you've been in a given location for a long enough period of time, I fire off a Foursquare API request to see if you're at a coffee shop. This API call is "anonymous", but I could imagine that in some circumstances it might be possible for Foursquare to associate that network request with your Foursquare account if you already use Foursquare or Swarm on the same phone and have background location enabled. In that case, Foursquare would already have the location data I'm sending them.

[^3]: The one exception to that is that if you add a drink that isn't in the default list, I track what it is, so if enough people add a drink I can make sure to add it as a default in a future version.