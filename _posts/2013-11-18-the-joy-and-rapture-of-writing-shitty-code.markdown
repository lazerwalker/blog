---
layout: post
title: "The Joy and Rapture of Writing Shitty Code"
date: 2013-11-18 10:23
comments: true
categories: [Software Development]
---

Recently, I've been pair programming with a whole bunch of people who are new to pairing and Agile development. I've noticed a trend: they've all been struck by the sheer volume of terrible code that I write. I take that as a compliment.

Writing terrible code is liberating. I'm obviously not advocating deploying code to production that you know is bad — ideally you're not even committing it to a central code repository — but I've found that spewing out half-formed thoughts in code is one of the strongest tools we have as programmers. Even if you're not practicing a "proper" Agile red-green-refactor workflow, there s a lot to be said for using the code-writing process as a tool to learn something meaningful about the problem you're solving.

When you start solving a problem, you'll come up with an idea for a solution. You'll typically operate under the assumption it's the best solution for the problem, but you don't really know that. You write some code, spend some time fretting and fussing over making it look pretty, and call it a day.  But even though you end up with something that's relatively polished and gets the job done, you don't really know if it was the best way to do things. More importantly, that time spent 'optimizing' your code might come back to bite you later, when you realize all that refactoring you did isn't going to help you implement the next bit of functionality. All that time you spent worrying about what to call that function name, or whether it should take two arguments or three, was useless.

How do you avoid that? Write shitty code. Your job as a programer is to do the absolute simplest thing possible that gets the job done, because the act of writing that code will likely illuminate a better way to do things. You'll notice patterns you wouldn't have otherwise noticed, draw inspiration from seeing your ideas written down that will point the way to a much cleaner factoring.

Whenever I talk about this, I'm reminded of [Bird by Bird](http://www.amazon.com/Bird-Some-Instructions-Writing-Life/dp/0385480016), Anne Lamott's classic book on writing. If you haven't read *Bird By Bird*, I highly recommend it; there are a lot of fascinating parallels one can draw between the creative writing process and building software. In particular, though, Lamott makes a very familiar argument for first drafts:

> The first draft is the child's draft, where you let it all pour out and then let it romp all over the place, knowing that no one is going to see it and that you can shape it later. You just let this childlike part of you channel whatever voices and visions come through and onto the page. If one of the characters wants to say, "Well, so what, Mr. Poopy Pants?," you let her. No one is going to see it. If the kid wants to get into really sentimental, weepy, emotional territory, you let him. Just get it all down on paper because there may be something great in those six crazy pages that you would never have gotten to by more rational, grown-up means. There may be something in the very last line of the very last paragraph on page six that you just love, that is so beautiful or wild that you now know what you're supposed to be writing about, more or less, or in what direction you might go -- but there was no way to get to this without first getting through the first five and a half pages.

You might feel embarassed writing that gigantic case statement with 10 options or that nasty nasty global variable, but that's really just your equivalent of "Well, so what, Mr. Poopy Pants?". If you can clearly describe a problem, you're often more than halfway towards solving it; for the same reason that [rubber-duck debugging](http://en.wikipedia.org/wiki/Rubber_duck_debugging) is so effective at finding bugs, simply writing some code — any code — that does what you want it to do will almost always help you find the cleanest, most elegant way to do it.

