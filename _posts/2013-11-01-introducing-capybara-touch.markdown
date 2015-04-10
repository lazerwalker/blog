---
layout: post
title: "Introducing Capybara-touch"
date: 2013-11-01 15:57
comments: true
categories: [Open Source, Code, Projects]
---

Testing mobile web apps is hard. Stop me if you've heard this one before: you're building a mobile web app, and trying to test drive it. Perhaps you're using an acceptance testing framework like [Capybara](https://github.com/jnicklas/capybara) or [Cucumber](http://cukes.info) that runs your tests against a desktop browser via Selenium, or maybe even some sort of headless Webkit instance. You write some tests for a new feature, and then some code that make the tests go green. You're excited to do a bit of light refactoring, ship your feature, and call it a day. But then you try loading up your app on an actual iOS device, and nothing works. You've been foiled again by Mobile Safari.

The past few weeks at [Hacker School](http://hackerschool.com), I've been building a new tool to solve that problem. I'm proud to announce [Capybara-touch](https://github.com/lazerwalker/capybara-touch), a Capybara driver that runs your tests against an actual instance of Mobile WebKit running in the iOS simulator. If you're having testing inconsistencies caused by idiosyncratic behavior in Apple's web browser, this will give you a testing environment that more accurately reflects your production environment.

Using it is easy. After installing the `capybara-touch` gem, all you need to do is set your Capybara driver to `:ipad` or `:iphone` within your spec helper or individual spec file. Assuming you're on OS X, running your specs as normal will cause an iPhone or iPad simulator to open up, display a UIWebView, and execute your tests against that browser. Naturally, actions such as taps and keypresses are synthesized at the system level rather than being faked in JavaScript; to the UIWebView, it's as if the input came from a human.

Running within a UIWebView rather than MobileSafari.app means that JS execution is limited to the slower, non-'Nitro' JavaScript engine, but performance considerations aside I have yet to encounter a situation where behavior has actually differed between the two environments.

There's still a lot of work to do, to be sure. It's slow. It's flakier than it should be. It doesn't yet have the ability to write tests against mobile-specific device features (e.g. the device orientation rotation API). But I'm really excited about the potential of this project. If you're trying to write tests for a full-featured iOS web app, or (even better!) if you're interested in contributing, I'd highly recommend [checking it out](https://github.com/lazerwalker/capybara-touch)!