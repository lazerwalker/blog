---
layout: post
title: "Speak No Siri, Hear No Siri: How I Built My Own Text-Based Phone Assistant"
date: 2013-02-24 16:50
comments: true
categories: [Hubot, AppleScript, Projects]
---

A few weeks ago, I decided to write my own Siri-like assistant I could use across all of my iOS devices using an iMessage-based CLI. Instead of having to open up dedicate apps to perform common tasks, or dictate things to Siri, I can just shoot off a quick text message and my faux-Siri will take care of everything for me. In practice it’s a lot closer to something like QuickSilver or [Alfred](http://alfredapp.com) than Siri, but whatever you want to call it, it's made my interactions with my phone much speedier and infinitely more pleasant the past few weeks I've been using it.

I’ve had enough interest from friends that I figured I'd put together a little write-up about what I did, why I did it, and how you can set up something similar.

## The problem
I love my iPhone, but I have one big oddly-specific beef with it. There’s no easy, minimally-distracting way to jot down a quick note. If I’m out with friends and someone mentions a movie or book I want to check out later, I feel bad disengaging by pulling out my phone to write it down. Every second I have to spend entering my unlock passcode, finding the right note-taking app (I like capturing things in [OmniFocus](http://www.omnigroup.com/products/omnifocus/)), and waiting for it to load is time I’m not focused on the people I’m with. Using Siri is quicker, but worse: taking out my phone to write down a note might be rude, but talking to Siri is actively distracting to others.

Apple recognized speed was a problem for photo-taking and added the fantastic camera button to the iOS 5 lock screen, but there's no equivalent for text content. What I wanted from my phone was a button on the lock screen that would give me a simple text box for capturing notes, with major bonus points if it could sync with OmniFocus.

## A solution!
Using [BiteSMS](http://bitesms.com) on my jailbroken phone, I can send text messages straight from my lock screen by pressing a hardware volume button and then tapping the heads-up display. It occurred to me that if I set up a remote service that responded to SMS/iMessage, that would give me the one-button-tap OmniFocus text input that I wanted. As a bonus, it could even perform other Siri-esque tasks like creating calendar events.

At startups I’ve worked with in the past, I’ve used GitHub’s [Hubot](https://github.com/github/hubot) as a chat robot for  internal team chatrooms. Hubot’s great: it’s easy to use, easy to set up, and easy to write custom scripts for. There’s already a custom Twilio adapter for Hubot, which lets you use Hubot over SMS, but that wasn’t ideal for me; it could easily get expensive (Twilio charges per SMS sent/received, and my phone isn't on an unlimited SMS plan), and I also want to be able to use Hubot from my iPad, which isn’t easily possible with SMS.

Instead, I built an adapter to let Hubot use Apple’s iMessage protocol. Apple doesn’t have a public iMessage API, so Hubot runs directly on my MacBook Air, using AppleScript to send and receive messages through Messages.app. Since it’s running on my main desktop computer, it has full access to my filesystem and can interact with any of my desktop apps via AppleScript; this means I can script it to do basically anything I want. Using iMessage as a transport layer means that I can let Apple handle security instead of having to worry about locking down my personal machine, and a contact whitelist makes sure that Hubot only responds to commands from my personal Apple ID.


## The result
An iMessage-based Hubot turned out to be exactly what I'd hoped for. When I turn my phone on, initiating a text message to Hubot just takes two taps. I can easily pipe data to a bunch of different services using special keywords: if I want to create an OmniFocus task to remind myself to take out the trash, for example, I just text “OF take out the trash” and it’ll get added to my inbox.

If I want to schedule a calendar event, I just text something like “cal lunch at Num Pang 1-2pm next Tuesday” and [Fantastical](http://flexibits.com/fantastical) takes care of parsing what I’ve written and adding it to my Google Calendar. If I end up buying a sandwich at that Tuesday lunch, I can just text "$8 Num Pang" and Hubot will fire off an API request to add an $8 expense to my budget-tracking software.

Since it’s so easy to add new functionality (all of the scripts I’ve written so far are at most 10-15 lines of code), I’ve spent the past week examining how I regularly use my phone to come up with more ways for Hubot to save me time. If I’m in a bar and want to read reviews of a new beer I haven’t tried before, for example, I can now just text “beer Stone IPA” and Hubot will send me back a tappable link that goes straight to the BeerAdvocate profile for Stone IPA (if you've ever used BeerAdvocate before, you'll know that their built-in search leaves a lot to be desired).

My setup might not have the raw power and language processing ability of Siri, but the scriptability and ability to add new tools perfectly tailored to my workflow more than make up for that shortcoming in my eyes.

If you’re interested in setting up your own personal iMessage-based Hubot, you’ll want to check out the [Hubot iMessage adapter](http://github.com/lazerwalker/hubot-imessage), and possibly my [personal collection of Hubot scripts](http://github.com/lazerwalker/lazerwalker-hubot-scripts). Let me know if you come up with any cool new tricks for your own personal use!