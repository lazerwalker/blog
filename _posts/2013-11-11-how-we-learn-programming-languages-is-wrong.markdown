---
layout: post
title: "How we learn programming languages is wrong"
date: 2013-11-11 00:13
comments: true
categories: [Software Development]
---

I've spent the past two weeks getting started with [ClojureScript](https://github.com/clojure/clojurescript) and [core.async](https://github.com/clojure/core.async). It's been been an interesting experience, not only because it's the first new programming language I've tackled in recent history, or even my first purely functional language, but rather because I've come to feel like there's something fundamentally missing with the approach I've been taking.

To clarify: there's a lot of inherent educational value in learning a language outside your comfort zone as an academic exercise — being exposed to unfamiliar programming paradigms is invaluable — but I'm going to be mostly talking about adopting a new language as a practical tool for building things.

## We have the tools

It's easy to learn the syntax of a new language. These days you can find a wealth of good reference materials online for pretty much any major language, and there are plenty of ways to get your feet wet building simple "Hello World" apps or working through the Project Euler problem set. I've been impressed by the elegance and expressiveness of the ClojureScript programs I've written, but they've all been on the order of a couple hundred lines of code; it's not hard to make any language appear simple and elegant in such a contrived situation.

It's also easy to understand on a philosophical level why you would want to use a given programming language or tool, especially for a language with a lineage like Clojure/ClojureScript. Every time I watch one of Rich Hickey's talks about why he built Clojure, I feel like he's voicing a deep truth about software development that I'd never before been able to verbalize.

## The missing step
From the standpoint of building software in industry (as opposed to, say, PL theory), a programming language is essentially a tool to help developers deliver business value. From that angle, a well-designed programming language is one that minimizes the cost of change over time while encouraging developers to make architectural decisions that also minimize the cost of change.

There's no objective measure of 'goodness' here, only trade-offs. Dynamic languages like Ruby enable kinds of metaprogramming that can be incredibly expressive, for example, but that comes at the expense of requiring more intensive testing to safeguard against the sort of mistakes that would be trivial to catch in a language with a stronger type system.

Unfortunately, a lot of these tradeoffs are very subtle, and many poor architectural decisions don't manifest themselves until you've written tens of thousands of lines of code. I know the common pitfalls of large single-page JavaScript web apps, but I don't know the downsides of building applications of similar complexity in ClojureScript. Nor do I have any idea how to learn that before investing a great deal of time into ClojureScript.

I don't know what tasks that would be trivial in JavaScript are going to be teeth-pullingly difficult in ClojureScript. I don't really know which of JavaScript's biggest frustrations are trivially avoided in ClojureScript. Most importantly, I have no sense of the relative proportions of each of those two categories. And it seems backwards to me that the only way I can figure that out (and thus decide whether trying to build larger-scale rich web apps in ClojureScript is a valuable endeavor) is by actually taking the time to do it.

I don't have a good answer yet, but I'm left with a vague sense that there has to be a better way.