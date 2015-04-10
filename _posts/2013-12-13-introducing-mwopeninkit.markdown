---
layout: post
title: "Introducing MWOpenInKit"
date: 2013-12-13 10:16
comments: true
categories: Objective-C, Open Source, Projects
---

For everything there is to love about iOS, there are a few parts that really grind my gears. One of them is the lack of a sensible solution for inter-app linking. I think it's stupid that if I tap a map link in a third-party app, I don't have the option to open it in Google Maps instead of Apple Maps.

I can't fix this for everyone; that ball's solely in Apple's court. But I can make it easier for other app developers to fix this problem in their own apps. [So I did](https://github.com/intentkit/IntentKit).

Every time any of my iOS apps has any external links, whether to maps or web sites or something else entirely, they'll be powered by MWOpenInKit so my users have the freedom to use whatever third-party application they want. If you're an iOS app developer, I'd highly encourage you do the same (not that I'm biased or anything).

I'm not going to pretend it'll move your bottom line in any way, but in many cases MWOpenInKit is actually easier to integrate than manually constructing, say, Apple Maps URLs. And, more importantly, your users will thank you.

### Update
In order to be more easily recognizable, MWOpenInKit has been renamed to <a href="http://intentkit.github.io">IntentKit</a>! I've been overwhelmed by the positive response to it in the community; please do check it out.