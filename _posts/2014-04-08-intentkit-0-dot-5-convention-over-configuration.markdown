---
layout: post
title: "Announcing IntentKit 0.5: Convention Over Configuration"
date: 2014-04-08 13:27
comments: true
categories:
---

I'm very excited to announce that a new version of [IntentKit](http://github.com/intentkit/intentkit) has been released!

This release includes a bunch of bugfixes and small improvements, including lots of great contributions from the community, but the most important change is an big improvement to the user-facing interface.

Previously, it wasn't possible to use IntentKit without making the user do extra work. If your user tapped a button in your app to get turn-by-turn directions, and they had Google Maps installed, they would have to tap through IntentKit's interface before actually getting to see their directions. They can toggle the "Remember my choice" switch and only have to see it once, sure, but requiring that explicit choice is still a distinctly un-Apple interaction.

With IntentKit 0.5, each INKHandler object now has a flag called `useSystemDefault`. By setting it to true, performing an action will cause it to just use the appropriate Apple first-party app by default. From the user's standpoint, the default behavior is as if you weren't using IntentKit at all.

For users who do want to use third-party apps, the idea is that they will instead be able to set their preferences from inside your app's settings. IntentKit now comes with a full-featured view controller you can drop right into your settings screen (or anywhere you want) that lets users view and set their app preferences for any actions they can perform in IntentKit. It's fully customizable, and feels right at home in any iOS 7-styled app. If you prefer to roll your own UI, there are public APIs to view and set preferences programmatically.

The big idea here is to allow for convention over configuration. Not popping up an IntentKit activity sheet every time a user tries to perform an action reduces friction for users who don't care about that sort of thing, while still giving power users the freedom to use third-party apps. This also mirrors the way a lot of other apps have implemented their own IntentKit-like functionality. It's not necessarily the right UX flow for every situation (I still use the old-style activity sheet in apps that are too simple to justify a separate settings screen), but having the option makes it that much easier to create a delightful experience for your users.

For now, the default behavior is still the old activity sheet. Adopting the new behavior implies adding a separate configuration screen elsewhere in your app, so requiring explicit opt-in makes sense. That may change in the future as we see how people are using it.

If you're not already using IntentKit, what are you waiting for? [Install it in your project](https://github.com/intentkit/IntentKit) today!  
