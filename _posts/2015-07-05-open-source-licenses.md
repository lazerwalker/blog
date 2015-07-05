---
layout: post
title: "Picking an OSS license for your iOS app"
date: 2015-07-05 12:30
comments: true
categories: cortado
---

More and more mobile app developers are embracing the idea of [open source by default](http://code.dblock.org/2015/02/09/becoming-open-source-by-default.html). In many circumstances, the benefits of putting your entire mobile application on GitHub are clear.

As programmers, we tend to wrap up a lot of ego in our code. Taking something you've written and putting it out in the world for others to do with what they like is a terrifying proposition; figuring out what rights you do and do not want to give others can be a very sensitive subject.

Let's look at some of the considerations you might want to take into account while figuring out what open source license to release your iOS app under.


# Different kinds of "freedom"

If you're already familiar with open source licenses, feel free to skip this section.

When talking about OSS, there are different definitions of "freedom", and different values that matter to different people. In broad strokes, the majority of popular OSS licenses tend to fall into one of two buckets: they're either BSD-style or GPL-style licenses.

A BSD-style license (BSD, MIT, Apache, etc) essentially says "do whatever you want with my code, as long as you give me credit and include a copy of this license"[^1]. You are given the freedom to use this code however you'd like, even in proprietary software.

GPL-style "copyleft" licenses say that any software you build using that code must be licensed under the same terms. They are "viral" in that any code that uses open-source GPL code must itself be open-source, with very explicit rules about what that means. 

To someone used to BSD-style licenses, the GPL is hardly "free", as it places very strict restrictions on the software you create. GPL-style licenses promote "freedom" in a very different, but equally valid, sense: they ensure that you as an end-user are always free to read and modify the source code of the software you use.

Of course, this is a bit of a contrived dichotomy. There are nuances to both styles of license I haven't covered here, and there are hundreds (if not thousands) of different licenses that grant diferent levels and types of freedom to users.


# Apps versus libraries/frameworks

The rest of this article, I'm going to be talking explicitly about open-sourcing user-facing iOS applications. Choosing a license for iOS libraries/frameworks is far more cut and dry: since GPL'd code can't be used in non-GPL'd apps, and most commercial iOS apps are not GPL (nor is that likely to change), releasing your iOS library under a copyleft license all but ensures that almost nobody will use it[^2]. Perhaps worth doing as a political statement, sure, but not productive if your goal is to put something out there for others to use.


# So what license should you use?

At the end of the day, it comes down to a simple question: why are you open sourcing your app? Do you simply want transparency, allowing others to see your code? Do you want to provide a source of education, letting people learn from your code? Do you want to actively solicit contributions?

There's no clear-cut answer without knowing what your goals are. Anecdotally, about half of the open-source iOS applications on [this list](https://github.com/dkhamsing/open-source-ios-apps) are using some form of GPL, and about half are using a BSD-style license (a roughly even split, it seems, between MIT and Simplified BSD, with a few Apaches thrown in for good measure). 

There's no silver bullet, only thinking through what you want.


# My thought process
As an example, let's walk through what went through my head when I recently open-sourced [Cortado](http://blog.lazerwalker.com/2015/06/25/location-as-intent-introducing-cortado.html), my caffeine-tracking app. As I sat down to think about what open-sourcing my app meant, I had a few goals (roughly in order of priority):

* People should be free to look at my code and take inspiration from it. I'm proud of a lot of the work in this app; being able to point to a specific git commit on GitHub and say "here's how I solved this problem, maybe that will help you" is incredibly valuable.
* People should feel comfortable contributing back to the codebase.
* People should *not* be able to take my app wholesale and release their own copy as-is on the App Store. I don't want a competitor coming along, rebranding my app, and spending a lot of money on marketing to compete against me with my own product.


# Can't I just license it for non-commercial use? Or tell people they can use any individual part of the codebase, but not the complete whole? Or forbid binary distribution?

This seems like it would be the obvious solution. You *really* don't want to write your own license, though. Unless you're a lawyer, or have lots of money to pay one, it's gong to get very complex very quickly, and probably won't end well for you. There's a reason people use vetted, pre-existing licenses.

Perhaps more importantly, your app won't technically be "open source". The Open Source Initiative (OSI) has [clear guidelines](http://opensource.org/osd) about what is and is not "Open Source", and any of those sorts of discrimination (restricting who your license applies to, the sorts of distribution you allow, etc) don't fit that definition.


# Choosing a BSD-style license

Let's say you're going to go with a BSD-style license. What does that mean?

It means that anyone can use your code for whatever purpose you want. If they release an exact copy of your app as-is on the App Store, with the same name and icon and everything, you can ask Apple to take it down on the grounds of copyright infringement. But if they just use your code, not your art assets, there's nothing you can do. 

Worth considering also is the licensing terms of any assets you might be using (icons, fonts, etc). The folks at [Artsy](https://github.com/artsy/eigen) are a great example of distributing a MIT-licensed app that carefully splits out what is properly free from what is not by including all app fonts via a separate CocoaPod, with their internal version of the app and the public release using different font pods.

This is a bold step to take, but the benefit is that people will feel 100% comfortable using your code, without worrying whether or not they're technically in violation of the licensing terms.


# Choosing a GPL-style license

Opting for the GPL has very different ramifications for iOS apps than desktop appliations.

Specifically, Apple's App Store distribution policies [place restrictions that are in violation of the GPL](http://www.zdnet.com/article/no-gpl-apps-for-apples-app-store/). As a result, GPL'd apps cannot, technically speaking, be released on the app store. Over the years, a handful of high-profile GPL'd apps, such as VLC and the game Battle for Wesnoth, have been pulled off the App Store for this very reason.

There is a workaround: if you're the copyright holder, you can grant Apple an exception. Normally, a core philosophical part of the GPL is making it so that all users have the same rights to a codebase, regardless of who wrote it. But in this case, there is a distinction between a piece of code's copyright holder and anyone merely licensing it: the copyright holder has the right to dual-license the code, or grant Apple an exception to the GPL.

What this means is that the copyright holder of a GPL'd codebase is allowed to distribute their app on the App Store, whereas nobody else can. In some ways, this is good: if someone just copied your codebase and submitted it to Apple as a clone, you have easy legal recourse to shut them down. In other ways, this is bad: if someone wants to use only a small part of your app's codebase within their app (presumably their app would be GPL as well), they aren't technically allowed to distribute that app *at all* on the App Store. 

That's probably not desireable. You might be able to come to sort of agreement with an organization or individual that wants to license part of your code, but in practical terms that's a pain in the ass that's going to preclude most from even considering it. In other words, releasing your iOS app as GPL all but ensures that nobody else will be able to use even part of your app's code. Maybe you're okay with this.

Also worth keeping in mind: this business with copyright means that if you accept third-party contributions to your app, you will need any contributors to grant you the appropriate rights to their work. Many GPL'd iOS apps have mandatory CLA (Contributor Licensing Agreements) in place; they are also fairly common for open-source repositories maintained by large tech companies. This isn't a major problem, but it is a barrier to contribution that's worth keeping in mind.


# So what do you do?

Both of these options – a BSD-style license or a GPL-style license – have clear tradeoffs. Do you want to encourage contributors and encourage others to use your code in their apps, at the cost of opening yourself up to someone just cloning your app wholesale? Or do you want to give yourself some more protection, but at the cost of making your codebase much more hostile to others who want to use it? It ultimately comes down to what your reasons are for open-sourcing. 

With Cortado, I chose to release it under the MIT license, with a (legally unenforceable) plead in the README to not simply release the app as-is on the App Store. For something like Cortado, anyone who wanted to build their own clone from scratch could do so fairly easily; there isn't anything about the technical implementation that's particularly novel. To me, encouraging others to contribute back or use bits of the codebase in their own work was a priority, so a BSD-style license seemed like a sensible choice.

Your reasons for open-sourcing, and the various factors surrounding it, will likely be different. Most important to any decision like this is knowing what your options are, and what the ramifications of any given choice are. 

Now go forth and open-source your apps!

[^1]: Many BSD-style licenses have other terms as well – the differences between them typically surround issues such as copyright and patent grants – but I'm painting with a broad brush.

[^2]: Theoretically, I'd bet one could release an iOS library under the [LGPL](https://www.gnu.org/licenses/lgpl.html), provided it's integrated into third-party apps as a compiled framework. I haven't actually seen this done in practice.
