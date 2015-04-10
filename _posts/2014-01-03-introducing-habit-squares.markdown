---
layout: post
title: "Introducing Habit Squares"
date: 2014-01-03 00:06
comments: true
categories:
---

I'm terrible at building new habits.

I've tried systems like Jerry Seinfeld's "[don't break the streak](http://lifehacker.com/281626/jerry-seinfelds-productivity-secret)" calendar before, but I haven't been able to make any of those work for me. Most of these things, whether they take the form of an app or just a physical calendar, require you to manually go in and check off that you've done something for a day.

For some people, that's great. For me, though, putting an 'X' on a calendar (or opening an app on my phone and tapping a button) is in itself a new habit that I need to train myself to do. In practice, I just end up forgetting to cross off and the whole thing becomes meaningless.

To that end, I'm proud to announce the open-sourcing of a tool I've been using for months now to help me build up new habits.



## Continuous Integration for your life
[Habit Squares](https://github.com/lazerwalker/habit-squares) is my attempt at solving this. It's heavily inspired by the Agile concept of a [continuous integration](https://en.wikipedia.org/wiki/Continuous_integration) monitor. With a CI monitor, you have a big TV screen up in your office that essentially shows the current state of your codebase. As developers check in new source code to version control, servers run your automated test suite on it. Each different project you have gets its own square on the TV screen representing the state of the automated build and test process. If the tests pass, a square representing the build is green; if they fail, the square turns red.

With Habit Squares, I wanted to build a "CI board for your life". It gives you an automated snapshot of how you're coming along at doing every repeated activity you want to do on a daily basis. I had two main design goals for it:

1. Just like a CI board, it should be designed to be displayed on a screen in a public place (I use a wall-mounted iPad in my office), so it's easy to see at a glance which daily activites I've completed and which I haven't.

2. I shouldn't have to manually check off that I've done something. It's 2014; it should be able to use the power of the Internet and third-party APIs to automatically figure out when I've accomplished what I want to accomplish.

Here's what it looks like:

[![image](/images/habit-squares.png)](/images/habit-squares.png)
(Click through for the full version. It looks much better.)

Each square automatically updates every sixty seconds with the latest data. At the bottom of each square is a series of smaller squares showing a rolling seven-day history. There's only room for eight squares; if you're trying to track more than that, you're probably using it wrong.

(The "Have I created something today?" and "Have I practiced piano today?" squares don't update automatically; they can be toggled on or off for the current day by tapping or clicking them.)


### What does 'releasing' mean for something like this?
I've had friends asking me to use this ever since I got the first version up and running, but I haven't been sure what 'releasing' it actually means. Many of my friends who wanted to use it are non-technical, but the biggest value I've gotten out of this has been from being able to easily program in new services when I have something new I want to track. Bridging that gap for non-programmers feels like a Herculean task without having the raw engineering power of a company like [IFTTT](https://ifttt.com) or [Zapier](https://zapier.com).

To that end, the initial release of Habit Squares is a source release on [GitHub](https://github.com/lazerwalker/habit-squares), ready to deploy to a free Heroku dyno or the like.

It includes the half-dozen or so services I've built myself, but the more important part is how easy it is to add your own services. I wrote Habit Squares in Ruby to take advantage of the world-class Rubygems ecosystem; if there's a third-party API you want to use, there's probably a gem for it. Because of that, most of my own personal services have been less than twenty lines of code.

If you end up using Habit Squares to get your habits and goals in order, let me know on [Twitter](https://twitter.com/lazerwalker) — I'd love to hear from you!
