---
layout: post
title: "IntentKit 0.6.0: In-App Actions and Other Fanciness"
date: 2014-05-14 09:17
comments: true
categories: IntentKit
---

I'm proud to announce the latest version of [IntentKit](http://intentkit.github.io) has dropped. It represents perhaps the biggest change to IntentKit since its initial release, and is something I'm incredibly excited about.

Previously, IntentKit assumed that any action it took would result in opening an external application. That's in many ways a false assumption, though; a lot of Apple APIs offer the ability to do things in-app by presenting a modal view controller, and there are rumblings of future iOS versions supporting something like that for third-party apps via remote view controllers.

IntentKit no longer makes that assumption. Namely, thanks to a whole bunch of architectural changes that I've been working on for the past month or so, IntentKit now supports actions that present a modal view controller inside the current application.

Right now, there are three actions this can be used for: sending email (powered by `MFMailComposeViewController`), posting tweets (`SLComposeViewController`), and viewing web sites (a custom view controller wrapping a `UIWebView`, containing some standard lightweight browser features). These are treated just like normal IntentKit applications available to respond to different actions from different handlers; the user can pick them the same as they'd pick any other external app using IntentKit. The API is flexible and easy to implement, however, so it's very likely we'll see more actions emerge in the future.

Here's a few examples of powerful workflows that would require a lot of work to implement manually but are trivial in the new version of IntentKit:

* **Viewing a user's Twitter profile**: if the user has Twitter.app installed, they'll be redirected to the user's profile in the native Twitter app. If not, an in-app modal web view will load the profile on Twitter.com.

* **Composing an email**: when tapping on an email address, a `MFMailComposeViewController` will pop up in-app just as is standard. However, if a power user would rather use a third-party mail client, they can go into the app's settings panel and manually specify that they'd rather send email using something like Mailbox or Gmail.app.

When updating your app to the latest version of IntentKit, you don't need to do anything to enable this; the default behavior is to replace Apple's first-party apps (Safari, Mail.app, etc) with these in-app equivalents automatically when appropriate. There are configuration flags on each handler object to change this behavior if you want to disable it (see: the [INKHandler class documentation](http://cocoadocs.org/docsets/IntentKit/0.6.0/Classes/INKHandler.html)).

The latest version has a lot of other changes as well, including some much more compact syntax (see the [CHANGELOG](https://github.com/intentkit/IntentKit/blob/master/CHANGELOG.md) for full details), but to me, this is one of the most important features IntentKit now has. Check it out!
