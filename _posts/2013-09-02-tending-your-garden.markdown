---
layout: post
title: "Tending Your Open-Source Garden"
date: 2013-09-02 21:44
comments: false
categories: [Open Source, Community]
---

Maintaining open source software is hard.

I had a frustrating experience this weekend. The technical details aren't relevant, but essentially I was trying to use a moderately popular open-source library in a slightly different way than you'd typically use it.

No problem, I figured. It's just a single JavaScript file, and I have a clear idea of what I'm trying to do: patching in my change shouldn't be a major hassle. After an hour or two spent groping through the code and the related example project — it would have been less, but halfway through I realized the example project was using a two-year-old copy of the library — it turned out that the functionality I needed already existed, it just didn't appear in the documentation. Whoops.

I sat down to add some documentation to the README, in the hopes of helping like-minded souls in the future. But then I noticed two different pull requests adding in that same documentation, neither of which had been merged in or even acknowledged by the maintainers. One of the pull requests even had a handful of other users chiming in how they had also only discovered the functionality by diving into the source.

To summarize: a maintainer clicking a single button to merge in three lines of documentation would have literally saved me an hour or two of work. And that's to say nothing of the four or five other users who apparently had a similar experience. Talk about frustrating.

I've heard it said that becoming successful requires two steps: doing awesome things, and telling people about it. In this case, this project had a whole bunch of really awesome functionality that *nobody knew about*. And not only did the project's maintainers not do a good job of advertising all the cool stuff their project could do, but when strangers on the Internet found out about it and thought it was cool enough to actively offer to help spread the word, they *ignored them*!

Maybe it's just me, but that seems crazy. Now, I know that maintaining open source software can be incredibly stressful and time-consuming. Even the healthiest of projects can become taxing when you have to deal with everything from support requests from inexperienced users to disagreements over the big-picture feature roadmap. But shirking your responsibilities as a project maintainer can lead to a negative feedback loop: if pull requests and bug reports continue to go unanswered, would-be contributers will stop making them, which is likely to cause you to spend even less time focusing on your ignored project.

This is all trivially obvious to anyone who's worked on an open source project, but we sometimes forget in the hustle and bustle of daily life. It's worth taking a step back every so often to remember that open source software isn't just about building something cool and releasing it into the world. It's about building a community, which means both letting people know about what you've built and being receptive when they want to contribute.


*As a brief postscript*: I explicitly didn't want to call out the project in question by name, because my goal wasn't to shout "GOTCHA!" and shame some poor unsuspecting maintainer. For all I know, there could be a very good reason that none of those pull requests have been merged in.

But I'm going to namedrop anyway, and here's why: the project, [jquery-pjax](http://github.com/defunkt/jquery-pjax), was created by one of the founders of GitHub; most recent commits have come from other GitHub employees. I don't know any of them personally, but being an avid fan of GitHub I feel comfortable saying they're all insanely smart people who mean well. More importantly, they've built a multi-million (multi-billion?) dollar business around the idea of making open source software more accessible. The fact that even *they* don't get it right 100% of the time  underscores just how hard it can be.