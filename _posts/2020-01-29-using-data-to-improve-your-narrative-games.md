---
layout: post
title: "Using Data and Analytics to Improve Your Narrative Games"
date: 2020-01-29 12:00
comments: true
categories: azure, game dev
---

When I speak with indie game developers making narrative games, a lot of people perk up when I mention analytics. Gathering data about user behavior can feel like a weird dark art: it often sounds like something you should be doing, but you don't quite know what to track or how to make sense of that data, and you probably also wonder about whether or not it's actually ethical to capture that sort of data.

This article is about how I use analytics in my [Twine](https://twinery.org) games! I'll talk about how analytics are "traditionally" used in large free-to-play games, as well as the ways in which that approach does or does not apply to people making small experimental narratives.

I'll walk through a few examples of how I've concretely found gathering analytics data useful in my work, as well as give some links to the free tools I use to do that data-gathering in Twine (largely the [PlayFab-Twine](https://lazerwalker.com/playfab-twine) tool I maintain).

Although my experience here — and the tools I mention — are largely grounded in Twine, this should be applicable to those making choice-based interactive fiction games in most any environment.

## How free-to-play games use analytics

Free-to-play games are by far the most regimented users of analytics data. To be clear, I don't want to endorse the way F2P uses data, and I think it's largely not relevant to people making free or premium interactive fiction games.

But it's still useful to get a sense for how they function before we talk about which specific elements to crib and which to leave be.

This is also a mile-high view; it goes without saying that I'm not trying to speak to how EVERY free-to-play game uses analytics. This is a sort of abstracted overview based on my personal experiences in free-to-play over the years.

### Guiding Metrics

For the most part, free-to-play games are laser-focused on a funnel:

1. You get new users into your game. In 2020, you're probably paying money to acquire them through channels like video ads.

2. Some number of these players will keep playing your game.

3. Of the people who keep playing your game, some of them will become paying players.

4. Once people are paying you, you want them to pay you as much money as you can get from them.

The goal of metrics is mostly to quantify each of these steps, so you can then run measured experiments to make small improvements to each of those steps.

If you can make the average retention longer, or increase the amount of money your average player pays, that can have huge returns in your profits.

For the most part, there are a few metrics that are universally tracked:

**Retention** is measured in terms of what percentage of players return a certain number of days after installing.

Day 1 — or D1 — retention is how many players come back the day after they install, D7 is how many people return 7 days after installing, so on and so forth. You'll typically track D0, D1, D7, and D30 retention.

Retention numbers beyond day 30 are often ignored. I'd argue that's likely a mistake, but that's a discussion for another day!

**Revenue** is exactly what it sounds like. You might track things like the average revenue per daily active user (ARPDAU), average revenue per paying user (ARPPU), or what percentage of your players give you any money.

Although you'll focus on those metrics as the most important things to track, you'll typically also use them as jumping-off points for finding other things to keep an eye on. A product owner on a free-to-play game will typically add lots of tracking into their game, with an eye towards answering specific questions:

- **When launching new features**: are people engaging with this the way it was anticipated? If you visualize a feature of a game as a funnel, where are people dropping off of that funnel?
- **Health checks**: games will often have a specific number that's indicative of overall game health. When I worked on Words With Friends, we looked at the total number of turns played by all players each day. If that number was unexpectedly low, that was a sign that there was something wrong, either with our servers or with a new design
- **Deciding what new features to prioritize**: new feature work will often be oriented around raising a specific metric, usually one of the key revenue or retention metrics

### This sounds gross. Why does this apply to me?

As a conceptual framework, this sort of numbers-driven approach to game design is intended to maximize how much time and money a player is spending on your game, typically using psychological tricks and addiction patterns taken from gambling. That's not great.

The good news is, even a I've just spent time describing this whole approach to analytics, it probably doesn't apply to you!

F2P narrative games certainly exist, but I'm writing this article for people who don't work in that space. If you're working on a game that's a bounded narrative experience — whether free or "premium" — you're (hopefully!) not focused on the sort of questions around optimizing money and engagement time from players that F2P designers are, you're much more focused on conveying some aspect of the human experience or evoking some sort of emotion in players.

In that situation, a strict application of F2P analytics techniques is actively going to make you a worse designer! But I do think it's possible to use similar techniques and tools to get a better sense of how players are interacting with your game, in ways that are qualitatively different from what you'll get from e.g. in-person playtesting. Having that information can help inform design decisions in ways that can result in a better experience for your players, in particular in the moments when your expectations turn out to not match up with reality.

It's also absolutely possible to gather that data without capturing personally-identifiable data on any given individual player, which helps me personally feel a lot less squeamish about this sort of data collection.

### Metrics aren't about individual players

An important point with metrics data is they're mainly useful in aggregate. If you're interested in charting out the journey a single player takes, just looking at numbers isn't going to tell you what that player is thinking or experiencing. Tools like in-person playtesting or quantitative surveys are going to be far more effective at that personal individual scale.

### So what _are_ metrics useful for?

I recently shipped a [small Twine game for work](https://microsoft.com/mysterymansion) that's essentially a short escape room game: you're in a spooky old house, and need to solve a bunch of puzzles.

Using my [PlayFab-Twine](https://lazerwalker.com/playfab-twine) tool (more on that later!), we were able to gather data on whenever a player visited a different Twine node in our game, with the ability to write complex queries around that dataset.

We broadly found analytics to be incredibly useful for answering a whole bunch of different design problems.

#### Who are our players?

Data about how many people played our game, how often repeat players came back, where players were coming from (geographic region / OS and browser version / etc), and how long people on average spent with the game was super useful to get a sense for who was playing our game.

#### Is our game broken?

Many interactive fiction tools have some sort of mechanism for validating that every passage is theoretically visible, basically by brute-forcing every possible path in the game.

For us, analytics was able to serve a similar goal: once the game was out in the hands of a large number of users, we were able to look at visit numbers for every Twine passage relative to the total user count. If any passage had 0 visits, or an exceedingly low number of visits, that was a strong sign there was likely some sort of engineering error that prevented players from reaching that content.

This isn't a replacement for traditional manual QA, but can still serve as helpful extra validation your game works as expected!

#### Where are players the most unhappy?

With our game's initial release, we were disappointed with how few players were playing the game all the way to the end.

Our game is a puzzle game whose structure is generally fairly open, but we have a few strict chokepoints where players must solve a specific puzzle to progress. This made finding the problem fairly easy: taking each of these chokepoints, we graphed out how many people viewed the Twine passage where they needed to essentially input the answer to the puzzle as opposed to how many people viewed the passage immediately following the puzzle.

This made it clear which exact puzzle in our game was too difficult. Adding some more aggressive hinting earlier in the game quickly fixed things, which we were able to verify both by looking at passage view counts for the "puzzle solved" passage as well as our metrics for overall game completion.

Using similar techniques, we were also able to look at the more nonlinear and multilinear parts of our game: when given freedom to wander wherever they wanted, what paths did players take? We were able to look both at overall view counts for individual passages (e.g. did more people go into the dining room than the study?) as well as ordering of the two (e.g. for people who went both upstairs and downstairs, which area did they explore first?).

Our game didn't have a particularly complex puzzle graph, so we didn't need to really make changes to the flow of our game in order to make it work, but having that sense of where players' eyes were naturally drawn would have given us a clearer sense of how to rearrange the game space's architecture if those had become problems.

#### But what if you're not making a puzzle game?

Your game might not as clearly break down into explicit discrete chokepoints, but this same general approach can tell you a lot about player data.

Often you'll design a choice with two options, expecting that roughly 50% of players will select each option. Tracking those passage views can help confirm whether player behavior meets your expectations.

If they're not, that then gives you the opportunity to either revisit the choice you're presenting players to try to get it closer to what you were imagining, or to lean into it and redesign other aspects of the game based on what that tells you about what your players are actually interested in.

If you're making an episodic game, you could also see how tracking this data can help influence future decisions. You don't want to make creative decisions completely at the mercy of your players, sure, but knowing that your players prefer a certain character or a certain type of gameplay might be useful data to have as you continue to write and design. And while asking players directly what they like is also a useful technique, it's equally useful to look at what players do rather than what they tell you.

#### How can we convey choices to players?

We didn't end up shipping anything like this in the final game itself, but we were really interested in being able to show Telltale style metrics to users within the game itself. After completing the game, we imagined players might be able to see "for this major choice, X% of players made the same choice as you".

Once you have aggregated data about how players interact with your game, you can imagine other interesting ways to surface this to players. It's not the right fit for every game, sure, but using your data to directly empower players can also help you allay your own concerns that you're using these metrics techniques for good rather than evil.

### Be data-informed, not data-driven

All of these tools are incredibly powerful, but it's worth reiterating that you shouldn't solely rely on metrics. Even in live F2P games, people talk a lot about having the wisdom to know when to disregard what the data is telling you.

Whatever your design goals are, you shouldn't look at metrics as numbers to obsessively optimize, but a very specific tool to use to augment your decision-making process. When you have a question about how players are interacting with your game, looking at data and constructing a specific query can be one way to get one specific perspective of what's going on.

Which is to say: analytics are great! Use them! But looking at metrics can itself become an unhealthy Skinner Box-esque system that triggers compulsive behavior in you as a designer.

### So how can I do this in my game?

Maybe you're reading all of this and saying "wow, that sounds great! I want to apply these techniques to my own game!"

How to get started depends a lot on what you're making, what tools you're using, and how technical you are.

I'm personally partial to [PlayFab](https://docs.microsoft.com/en-us/gaming/playfab/#pivot=documentation&panel=playfab&WT.mc_id=blog-playfabtwine-emwalker). It's a hosted web service that basically aims to power your game's backend. It's intended to be used in rather large F2P games, where it can do things like manage your game's entire economy and social systems, but I really like using it for small-scale projects just for things like user authentication, leaderboards, cloud saves, and analytics. Every personal project I've worked on has fit within its free tier (even my game [Flappy Royale](https://flappyroyale.io), which had nearly 200,000 DAU at its peak)

For analytics in particular, I appreciate that it's focused specifically on the needs of game designers, rather than people building business-focused web applications.

Being owned by Microsoft is also a plus from a privacy standpoint: most popular large analytics services are owned by ad providers, which gives them a perverse incentive to sell your users' data. There are a ton of smaller startup analytics tools that are great as well, but they're historically likely to be acquired by those same large ad companies. Using a tool owned by a large stable company like Microsoft that isn't in the advertising business seems like the best of all worlds.

If you're a coder, PlayFab is easy to get started with. Whether you're writing in Unity, Unreal, JavaScript on the web, or anything else, it's usually only a few lines of code to authenticate with PlayFab and start sending real-time analytics data. Check out their [getting started guide](https://docs.microsoft.com/en-us/gaming/playfab/personas/developer?WT.mc_id=blog-playfabtwine-emwalker).

If you're using Twine, I maintain a tool called [PlayFab-Twine](https://lazerwalker.com/playfab-twine) designed to make it as easy as possible to add analytics to your game via PlayFab without writing any custom code.

With only 5-6 lines of JavaScript copy/pasted into your Twine project, and a few minutes' worth of configuration, you'll be able to use PlayFab's web UI to answer the same sorts of questions I did for the Mystery Mansion project.

### Go forth and measure things!

Hopefully this has been a useful intro to the world of how analytics can (and can't) help your narrative game! I'm excited for you to start gathering and making decisions influenced by (but not too heavily!) actual real-world data from your players!

Please do drop me a note on [Twitter](https://twitter.com/lazerwalker) if you do something cool with what I've talked about!
