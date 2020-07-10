---
layout: post
title: "Building a better online hallway track"
date: 2020-07-09 10:00
comments: true
---

As the effects of COVID-19 have been going on for months, we've grown accustomed to new forms of socializing. "Tech conferences" now mean Twitch and YouTube streams, casual hangouts with friends mean mass Zoom calls.

I don't know about you, but I find all of this _exhausting_.

I go to tech conferences primarily to have good conversations with people, but that's difficult in Twitch chat or even a dedicated Discord or Slack. Casual community meetups that used to be a short presentation followed by a few hours of unstructured socializing are now nothing but rigid slide decks. Communities that previously felt like joyful spaces where I could connect with old friends and meet new ones now feel like nothing more than yet another indistinct icon in my Slack or Discord app sidebar. "Attending a conference" means sitting in the same physical environment I use for work, and using the exact same pieces of software I spend my work days in.

There has to be something better!

## A solved problem in VR?

There are a lot of social virtual reality spaces that do a really effective job of this! I attended Microsoft's Mixed Reality Dev Days conference in [AltSpace](https://altvr.com), and I've run smaller meetups in [Mozilla Hubs](https://hubs.mozilla.com).

These spaces do a lot of things really well!

**Nonverbal comunication**. The performative nature of videochat makes it way more emotionally exhausting than a phone call or an in-person conversation, but dropping down to just audio chat loses a lot of the nuance of nonverbal communication.

Even though VR doesn't have a widely-available solution for conveying emotion via facial expression, most VR experiences communicate players' head and hand positions, which go a long way towards expressing emotion and intent without making you feel like you're "on camera" like when everybody's looking at your webcam feed.

**Natural conversation flow**. When you're at a party or meetup in real life, conversation circles are fluid. A group of four people might naturally split off into two separate conversations, then effortlessly rejoin again a few minutes later, and they won't even consciously notice this is happening.

That isn't possible on a 30-person Zoom call, and you end up with large stilted group conversations that wouldn't happen in-person.

A lot of videochat programs (Zoom included) have 'breakout room' functionality. A moderator splitting people off into randomized small groups for a fixed period of chat time can be an effective way to foster meaningful and interesting conversation, but the rigid formality of being told when to break out and when to rejoin the larger group lacks the spontaneity and fluidity of real-world conversations.

VR social spaces fix this! The combination of feeling embodiment in a virtual space and positional spatial audio means that a lot of VR meetups I've went to have managed to recreate the conversational dynamics of in-person meetups. This is phenomenal!

**A sense of play**. Even if you have the ability to walk up to somebody and start a conversation with them, that's a nerve-wracking thing to do! Some of my closest friends I've met at conferences are ones I met through having some forced reason to interact with them: waiting in the bathroom line in front of them at a party, sitting next to them at a conference talk, visiting the same sponsor booth at the same time as them.

Inhabiting a 3D space in VR helps provide some of this, but it still lacks a lot of the forcing functions that exist IRL. You don't need to wait in a bathroom line, for example!

A lot of VR social spaces solve this through providing opportunities to play. Beautifully-designed 3D environments encourage players to explore, giving them the chance to run into other people as they wander the space. Commenting on somebody's cool custom avatar can serve the same icebreaker as commenting on a sticker on their laptop. Interactive objects can give people the literal chance to play with each other, and strike up a conversation based on that.

## ...but VR isn't perfect

Everything I'm describing sounds great, but has a huge problem. Accessing any of these spaces presupposes you have an interest in VR, an expensive VR headset, and likely a top-tier gaming PC.

A lot of VR social spaces are accessible to people without VR headsets, but that's still tricky. Without head- and hand-tracking, you lose a lot of the communication nuance that makes these spaces work. PC-based apps still have relatively high hardware requirements, and the spaces that work on smartphones (such as [Rec Room](https://recroom)) tend to be designed for small casual friend hangouts rather than the sorts of larger events where you're trying to network or make new friends.

Most importantly, this stuff is _completely incomprehensible_ to people who aren't used to VR or playing 3D games. VR meetups are _great_ if your audience is VR developers. For anyone else, the basic cognitive overhead to even understand how to navigate a 3D space is a huge barrier to entry.

## So what's the solution?

All of these problems are solvable. The conferences and meetups I've attended in VR have felt great, with the caveat of the exclusivity and inapproachability of VR. The question is how to build new tools that take all of the design principles that VR virtual world designers have internalized and applying them to more accessible forms where you're not necessarily already speaking the language of being in a literal fully-realized 3D virtual world.

I've tried a lot of new tools that have sprung up recently attempting to provide this sort of social space. It's frustrating when so many of them are clearly attempting to augment existing chat tools with additional functionality. Fostering the sort of spontaneous social interactions that come naturally in real-life spaces is an incredibly difficult problem when most attempts to force spontaneity inevitably feel, well, forced.

So how do you create spontaneity in a way that feels natural? I think you need to create something that fundamentally feels like its own unique space that players/attendees have agency over. Something where the act of existing in the space itself, and trying to express yourself, naturally leads to creative and playful and frivolous behavior, which in turn creates room for the spontaneity we so desperately desire to exist.

I'll hopefully have more to share soon about the prototypes I've been working on, and in the coming weeks I'll also be publishing a series of articles about open-source tools I've been building to make prototyping and experimenting these sorts of experiences easier.

But to frame this one last way: if you asked me if I would rather attend a group video chat with some dear friends, or have us all join a [shared spreadsheet](https://onezero.medium.com/party-in-a-shared-google-doc-d576c565706e) with no way to communicate but typing into cells, I'd pick the spreadsheet every time.
