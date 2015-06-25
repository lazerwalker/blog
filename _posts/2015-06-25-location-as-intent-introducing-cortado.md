---
layout: post
title: "Location as Intent: Introducing Cortado"
date: 2015-06-25 11:00
comments: true
categories:
---

I've written before about how terrible I am at building new habits. While tools like my [Habit Squares](http://blog.lazerwalker.com/2014/01/03/introducing-habit-squares.html) can make it easier to enact large-scale habit change, that doesn't really solve the problem of the sort of self-tracking that relies on meticulous logging of your own personal activity. I've been playing around with solutions to this problem for a while now, and I've got something pretty cool to show you.

I like tracking my personal caffeine intake. I correlate it with my sleep data so I can figure out how much caffeine is too much, or how late in the day is too late. But tracking caffeine is hard. I'm not going to remember to manually keep track of every time I have a coffee, even though that's what all existing caffeine-tracking apps I've found do.

So I built an app called [Cortado](https://itunes.apple.com/us/app/cortado/id969899327). If you open the app, it has a pretty straight-forward UI. You can add new caffeine data, view your history, or whatever; it's not really intended that you'll spend a lot of time in the app itself. Here's what it actually does: whenever it detects you're at a coffee shop, it'll send you a push notification that looks something like this:

<center>
    <img src="/images/cortado-swipe.gif" alt="Cortado has interactive notifications" style='height: 125px'/>
    <img src="/images/cortado-watch.png" alt="It also works great on the watch!" style='height: 250px; margin-left: 20px; margin-bottom: 20px'/>
</center>

It knows you're at a coffee shop. It knows what your caffeinated beverage of choice is. Why not make life easy for you? Using the interactive notifications introduced in iOS 8, all you have to do is tap "Latte" and the caffeine data will be added straight to both Cortado's internal database and Apple's HealthKit. 

If you're not drinking any of the beverages it suggests, tapping 'Other' opens the app straight to the drink picker, with all other fields pre-filled. If you're busy when it pings you, you can deal with the notification later, and it'll remember when you *actually* had the coffee, rather than when you tapped the add button.

I've been using Cortado for months now, and it's fantastic. Not ony does it get me to actively track my data, and put it in a format that's easily accessible and exportable, but it makes the tracking proccess actively delightful. Every time my wrist buzzes to ask me what I'm drinking, I feel like I'm living in the future.

In the grand scheme of things, caffeine tracking isn't the most interesting problem; reducing that friction isn't going to make the world a meaningfully better place. But the core idea of using location to derive intent is really interesting. In context of self-tracking, it makes it far easier for average people to track their data in an enabling and empowering way. In a more general sense, this sort of interaction model feels like a way to help reduce the cognitive load modern technology places on our day-to-day lives.

Cortado is available for purchase on the [App Store](https://itunes.apple.com/us/app/cortado/id969899327).