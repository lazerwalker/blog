---
layout: post
title: "Apple and Machine Learning"
date: 2016-06-16 14:45
comments: true
categories: 
---

As we reach the end of WWDC 2016, I keep coming back to one of the more unassuming announcements. In iOS 10, Apple will be doing a bunch of deep learning tasks – the given examples mostly surrounded image classification, like detecting your friend's faces in your photos – on-device instead of in the cloud. 

From a strategic standpoint, it makes sense. ML, buzz-wordy as it is, matters, and Apple is provably worse at it than Amazon or Google or Facebook. Even if they hired as many smart ML experts as they could, it's naïve to think they could close that gap. Mythical Man-Month truisms aside (nine women can't make a baby in one month, etc.), the relative weakness of Siri compared to Alexa and Google's speech services suggests that not even an acquisition would move that needle too much. 

What Apple does have on their side is user privacy. They've been making a point of emphasizing privacy, from iMessage's end-to-end encryption to the DOJ kerfuffle to their newly-announced work with [differential privacy](http://blog.cryptographyengineering.com/2016/06/what-is-differential-privacy.html). Making the same push with their ML work makes perfect sense. If Apple can position themselves as the only company doing "deep learning" in a way that preserves user privacy, they no longer have to be *better* than Amazon or Google, they just have to be *good enough*.

That much is well-trodden Apple pundit territory. Much ink has been shed about both Apple's weakness in ML and their increased focus on privacy. But what's way more interesting to me is the tactical level of how they're actually trying to accomplish this. Modern deep learning is largely GPU-bound, and needs huge amounts of data, so it generally happens in the cloud on servers with beefy GPUs. Apple is infamously terrible at cloud services. They have, however, gotten very good at ekeing out low-level GPU performance with their Metal framework. 

It should come as no surprise that part of the upcoming changes to Metal and Accelerate are public APIs for building convolutional neural networks, both [low-level convolution primitives](https://developer.apple.com/library/prerelease/content/samplecode/BasicNeuralNetworkSubroutines/Introduction/Intro.html#//apple_ref/doc/uid/TP40017299) and [higher-level tooling for constructing CNNs](https://developer.apple.com/reference/metalperformanceshaders). In broad strokes, they're shifting the technical problem from one they're terrible at to one they already have great proficiency in. Smart.

Will it work? Beats me. I'm not quite savvy enough with ML and CNNs to know right now whether their on-device stuff performs as well as it needs to. But besides having potentially huge implications for Apple's strategic position, it also points towards an interesting future for hobbyist machine learning tinkerers. 

Creative coders are starting to do really interesting things with deep learning and neural nets (I'd point to [Ross Goodwin](http://rossgoodwin.com)'s work, or my own IndieCade East 2016 [talk](https://www.youtube.com/watch?v=qEWIlEF-f3Y&feature=youtu.be&a)), but the barrier to entry of specialized hardware is onerous, even given the abundance of relatively cheap online cloud computing power (Ross Goodwin, for example, has been fortunate enough to have access to powerful server clusters as a student at NYU ITP). Running something like [neural-style](https://github.com/jcjohnson/neural-style) locally, whether on the CPU or consumer-level GPU, is many orders of magnitude slower than running it on Amazon EC2 with a dedicated GPU. I doubt Apple's new additions to Metal are *that* earth-shaking, but even if some small subset of convnet usecases are now slightly more viable to run on consumer hardware, that could open up meaningful doors for people trying to do interesting things with machine learning.