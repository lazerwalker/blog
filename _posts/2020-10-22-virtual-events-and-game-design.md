---
layout: post
title: "Using Game Design to Make Virtual Events More Social"
date: 2020-10-22 12:00
comments: true
---

_This is part of a series of posts about Roguelike Celebration 2020! If you like this, you may also like my post about the [technical architecture of our social space](https://blog.lazerwalker.com/2020/11/20/serverless-virtual-worlds.html), our [streaming AV setup](https://blog.lazerwalker.com/2020/10/13/roguelike-celebration-av-setup.html), or the [open source codebase](https://github.com/lazerwalker/azure-mud) for the social space._

A few months ago, I had a conundrum: I couldn't stand virtual conferences.

I personally go to in-person conferences to talk to people: to catch up with friends, to make new friends, to have intellectually stimulating conversations. I'd personally rather watch talk videos at home on my own time than spend my limited time at a synchronous event watching them. 

Current virtual events are almost entirely talks! We know how to record and broadcast talks over the Internet really well; we don't know how to replicate the social side of things, or the quote-unquote "hallway track".

At first, this wasn't a huge problem for me. I mostly just avoided virtual events except for the occasional speaking engagement, and started doing some experimentation on the side about designing new types of online social spaces to foster the sort of small-group conversation I was missing.

But then it became time to organize this year's [Roguelike Celebration](https://roguelike.club), a game design conference I've helped run for the past four years, and the conundrum revealed itself. If I was going to spend my time and effort bringing an online event into existence, I wanted it to be one I actually wanted to attend!

I pitched the team on something radical: instead of using Zoom and Discord, what if we built our own event platform and social space, built from the ground up to foster the sorts of intimate social interaction that made the in-person event special?

Roguelike Celebration ended up becoming a test-bed for a text-based social space and online game that served as the digital venue for our 2020 event, adopting design techniques taken from online games and virtual worlds to encourage meaningful interaction and conversation between attendees.

This article is going to walk through the underlying design decisions that led to what we built, as well as talk a bit about the space itself.

## So what was the space?

To contextualize everything I'm about to say, let me explain the space itself.

As mentioned, Roguelike Celebration took place in a custom browser-based text-based social space. Most of the UI and UX design were based on modern chat apps like Discord and Slack, but structurally it much more resembled MUDs, the text-based precursors to modern online MMOs.

<center style='margin: 2em'>
    <a href="/images/roguelike-design/1.png"><img src="/images/roguelike-design/1.png" alt="The registration desk" style='max-height: 400px'></a>
</center>

Each attendee starts by creating a profile that contained not only their name, pronouns, etc, but also a text description of what their avatar looks like, visible by all other attendees. They are then dropped into a chat room with a virtual "registration desk", from which they can navigate to other rooms in the virtual conference space we had built.

<center style='margin: 2em'>
    <a href="/images/roguelike-design/2.png"><img src="/images/roguelike-design/2.png" alt="Map of the space" style='max-height: 400px'></a>
</center>

"Rooms" in this space are more like rooms in a MUD or online game than in Discord or Slack. Each room has a text description of what it contains, with hyperlinks to navigate to adjacent rooms, as well as fun novel things attendees could interact with. 

We tried to strike a balance between being a "normal" event venue and being playful: there were locations like a quiet lounge and an exhibition hall where we were showing a curation of games, but there was also a dance floor with a DJ set your avatar could dance to, the bar was serving polymorph potions instead of alcohol, and the foyer happened to be haunted.

As a particularly important example, the "theater" contained our talk livestream embedded right in the page. So when talks were starting, attendees would all move to the theater just like they would at an in-person conference.

<center style='margin: 2em'>
    <a href="/images/roguelike-design/3.jpeg"><img src="/images/roguelike-design/3.jpeg" alt="Streaming talks in the theater" style='max-height: 400px'></a>
</center>
 
Each virtual room was also its own chat room. Like in other online virtual worlds, you can only take part in conversations in the room you're physically in. If you want to talk to other people, you have to move to another room.

<center style='margin: 2em'>
    <a href="/images/roguelike-design/4.jpeg"><img src="/images/roguelike-design/4.jpeg" alt="Swag table" style='max-height: 400px'></a>
</center>
On top of the theater broadcasting our live talk videos, most individual rooms had their own exciting special activities going on. The kitchen had a vending machine that would produce randomly-generated food items you could pick up and carry around with you, while the dance floor had embedded chiptune DJ sets you could make your character dance to. Fun easter eggs and things to explore or pick up or interact with filled every room of the space.

<center style='margin: 2em'>
    <a href="/images/roguelike-design/5.png"><img src="/images/roguelike-design/5.png" alt="Octopode" style='max-height: 400px'></a>
</center>

### Entirely text-based?!

The fact that the space was text-based was largely done for logistical, rather than aesthetic, reasons. 

The hardest problem we were solving was figuring out what sort of tone and what level of game-like interactions would help foster the social dynamics we were aiming for. Using text meant we could rapidly iterate on content and systems, rather than getting caught up in the additional complexity of building a 2D or 3D rendering system or having higher asset production costs. 

Even using ASCII graphics (a la classic roguelikes) would have added in a lot of complex design problems to solve that we were able to sidestep with text descriptions. 

That said, it wouldn't surprise me if being text-based would still still be the correct design choice even given more design resources. Text descriptions can be a lot more evocative than representational graphics, and having something look a bit less like a traditional videogame helps make the space feel appropriate for a professional conference.

Overall, the response was overwhelmingly positive. Many, many attendees remarked on how Roguelike Celebration felt the most like physically "attending" an event to them since quarantine started.

## How did we get here?

My chief design goal was to create a social space where people could have small group conversations: say, a conversation with 2-10 people where maybe you know some of the people, but it's just as likely you won't know anyone. 

Given that overarching goal, I quickly settled on a few key design tentpoles:

### A novel space is inherently valuable

In games, we talk about the idea of the "magic circle", a boundary that clearly delineates the space where a game or play takes place as distinct from the normal world. Activities within the magic circle being distinct from normal reality gives people freedom to express themselves more freely and to, well, play (within reason and established safety limits, of course). 

A similar thing happens with in-person conferences. The event venue (especially if in a destination location!) serves as a freeing liminal space that helps attendees be present and engaged. Whether you're at a conference to learn from the talks, to meet new people, or frankly to just enjoy a free employer-paid vacation, the act of being in a different physical place does a lot to get you in a mindset where you're ready to embrace new experiences.

This is difficult for online events in the time of quarantine! If you're like me, you're largely spending 40 hours a week sitting at home, using Slack and Zoom or some other similar text and videoconferencing software. Asking people to spend their weekends at their same computers attending a Zoom conference with a Discord or Slack doesn't accomplish that goal!

We realized that, even if our custom social space was otherwise a complete and utter failure, the mere act of having it be a new and novel space would still be valuable.


### Allow small-group conversations at a technical level
Having a conference Discord or Slack means having a few hundred people in the same dozen text channels. This setup affords two different modes of interaction: people can talk in those large public channels with a few hundred participants, or they can slide into other people's DMs for 1:1 chats. 

Neither of these are particularly great for enabling intimate group conversations with strangers! In particular, we talked to a large number of potential attendees who expressed extreme discomfort and anxiety about trying to have any sort of conversation in those large public hundred-person chat channels.

Conversely, VR social spaces such as AltspaceVR or Mozilla Hubs do a great job of enabling the sort of fluid small-group conversations you get naturally in-person. Physical presence, spatial audio, and body language cues from head-tracking and hand controllers mean that you can naturally split off from a group conversation to start a smaller conversation, and then effortlessly rejoin the larger conversation whenever you want, similar to how you would in a physical setting. 

But I've regrettably found VR social spaces to be completely inaccessible to people who aren't VR enthusiasts, even when using software like AltspaceVR or Hubs that technically support non-VR desktop and mobile devices.

We knew we needed to find a technical model for chat that, while not in VR, was closer to what VR offers than to Slack.

Borrowing the spatial chat model from MUDs gave us the property we wanted where you could be in a room with a small group of people having an intimate conversation!


### Playful design adds spontaneity
Even if we create a space where people _can_ talk to each other in small groups, that doesn't mean they will. Striking up a cold conversation with a stranger is hard and scary!

At in-person events, there are a number of easy hooks that make it socially acceptable to initiate small-talk. You might strike up a conversation with the person sitting next to you in-between talks about the talk you've just seen. You might comment on a sticker on someone's laptop, or the logo on their t-shirt. You can walk up a sponsor booth and know that someone sitting there will be thrilled to chat about their company.

We don't have any of those affordances by default in online spaces!

My hypothesis for Roguelike Celebration was that we could fill that void by integrating game mechanics and playful elements borrowed from online games. 

In particular, I was inspired by [Dan Cook](https://lostgarden.home.blog)'s work at Spry Fox around how to design MMOs to encourage formation of meaningful friendships. His design work and writing is primarily concerned with helping people form deep friendships over the course of months or years, rather than us trying to get people to be mildly friendly over two days, but a lot of the core concepts he talks about in his [GDC talks](https://www.youtube.com/watch?v=voz6S7ryWC0) were still directly applicable.

A particular piece of social science he explores is the idea that friendships are formed through **repeated spontaneous interactions over time.**

This model reinforces some design decisions I've already explained: if you want spontaneous interactions, that seemingly requires a more spatial chat model than a giant Discord server where everybody is always in the same chat rooms at the same time. 

From there, adding game-like and playful activities to the space can encourage these moments of spontaneous interaction to happen more frequently. 

To ground this in a concrete example, the space had a bar area where attendees could drink a polymorph potion (designed/implemented by [Alexei](https://twitter.com/ampepers) and [Kawa](https://twitter.com/kawaidragoness)) that would add a random emoji to the front of their name. Let's look at all of the ways this simple playful element provided social value to attendees:

* People who needed a break from conversation could wander off to the bar and drink a few more polymorph potions as a sort of fidget activity
* Because this was an exciting special thing that was only available in the bar, this encouraged people to move in and out of the bar regularly, letting the bar serve as a sort of conversational nexus where you could bump into someone you knew (or didn't know but had seen in other rooms)
* Seeing other attendees with cool emojis encouraged people to explore the space to find other secrets like that, helping attendees circulate to different rooms and increasing the chance of spontaneous interactions
* When someone couldn't figure out how to add an emoji to their name, they'd ask people who already had emoji, giving people an excuse to be helpful and get to know each other in the process
* Being able to have some control over your emoji — you could drink as many potions as you wanted with no ill effect, so you could keep chugging until you got an emoji you particularly liked — served as a form of player expression. This is both extremely satisfying as an attendee and serves as a great conversation opener for other attendees.
* Running into someone with the same emoji as you was a particularly potent way to start a conversation and instantly feel affinity towards a stranger.

Most of our playful elements like this were fairly simple due to time constraints. I'd love to explore more complex and involved systems for future events, but you can see here how even the simplest game-like interactions can massively impact the sociability of the space.


## Video chat is valuable in moderation
Video chat is far more effective than audio chat at helping convey emotional nuance, and audio chat is equally more effective than text chat. This is important if our goal is to foster new friendships and interesting connections! 

But at this point in quarantine, we're all well aware of Zoom Fatigue. It's clear that running an entire conference on video or audio chat is a great way to burn everyone out.

As we spoke with potential attendees, we realized there are broadly two types of online communicators: those who are happier communicating online in text, and those who are happier using videochat to the extent that they have the emotional energy. Finding a way to make both groups of people feel comfortable and socially stimulated felt like a valuable goal.

This led us to aim for an event where communication over text chat was the default, but there were many opportunities for attendees to consensually opt-in to escalate into audio or video chat. Being primarily based in text chat lets attendees save up their emotional energy for focused higher-quality moments of video conversation, and grounding those moments in opt-in activities means that each individual attendee can self-moderate how much video chat they can handle.

Our plan for video chat in the space was twofold: we planned to schedule discrete blocks of time for video chat-based networking sessions, but also offer lower-key videoconferencing in every room that people in that room could join at any time.

For the former, we held unconferencing sessions where attendees could propose and upvote discussion topics, which were then assigned to specific rooms. We also intended to schedule breakout room-style networking sessions (where you would be randomly moved into a videochat with 3-5 random people for 10 minutes), but couldn't find room in our final conference schedule. These are the two structures I've seen work particularly well for structured video chat to avoid the anarchy and fatigue of unstructured 30-person Zoom calls.


## Putting it all together

Combining all of these design ideas, we ended up with a space that, by all accounts, was fairly successful at achieving its goals. 

As mentioned, I was blown away by how many of the remarks about the space talked about a sense of physical presence that mirrors the way people talk about VR — this felt to people like they were physically "attending" our conference in ways they hadn't felt before with virtual events. 

One moment that sticks with me was when an attendee set up shop at a specific table in the kitchen and did tarot readings for anyone who brought her an offering (of any object taken from elsewhere in the space). To me, this level of an attendee buying into the fantasy and aesthetic of our space, and contributing their own playfulness to the mix, is a ringing endorsement for our game-like and playful approach.

<center style='margin: 2em'>
    <a href="/images/roguelike-design/6.png"><img src="/images/roguelike-design/6.png" alt="Tweet advertising tarot readings" style='max-height: 400px'></a>
</center>

One pain point we did run into was just not having enough ways to test what we were doing. We were able to run a "preview event" that served as a test of the space (both from a design and from a technical load-test standpoint), and that proved essential in shaping the design of the space for its final iteration. But for the most part, it's incredibly difficult to playtest or validate your designs ahead of time when doing so requires dozens to hundreds of people. 

There are a ton of things I'm eager to change for our next iteration, as well as new hypotheses I have for how we can be more effective at encouraging conversations. But it's also still unbelievable to me that we accomplished as much as we did with about three months of development time (mostly me, plus contributions from a handful of amazing conference organizers and volunteers) and only that one public playtest session.

## Call for Collaboration
This social space was essentially an experiment intended to test my hypothesis that borrowing elements from online games — physicality, playful interactions, etc — would create a space where people could have the sorts of small person-to-person interactions I've been missing from online events. 

I think it was about as successful at that as I could reasonably hope, but it was also built for an audience perfectly suited to what I built. As a conference of mostly game designers, attendees were broadly familiar with the sorts of interface paradigms and game mechanics they were being presented with, and they're already used to the idea that a professional conference can be playful and silly and fun. 

I think all the work I'm doing is interesting and broadly applicable to other communities, but figuring out how to make it accessible to wider audiences is a complicated problem!

All of the code for our social space is [open-source](https://github.com/lazerwalker/azure-mud), and anyone could technically build their own space based on my work without my input. But this design space is so nascent and so experimental that I think it would be hard to use this codebase without more context around the social design decisions we made. Which is to say, I suspect the most successful second deployment of this tech would be one that I continue to be involved in.

I'm excited to work with conference organizers to figure out what that would mean! If you have an event that you think could work well for something like this, shoot me an [email](mailto:socialspace@lazerwalker.com) or [Twitter DM](https://twitter.com/lazerwalker) and let's chat about how the work I'm doing can benefit your community!

## This isn't just about this space

Maybe you don't run synchronous online events. Maybe you do, but you think a text-based tool like this isn't right for your community. More than talking about great the specific thing I built is, I want to hammer home the idea that designers of online games and virtual worlds have been thinking about and solving these social design problems for literal decades. 

The most effective way to make online events more engaging is going to be looking towards game design and virtual world design to learn what makes those spaces tick. 

This doesn't (necessarily) mean making actual games. Our space more resembles Discord or Slack from a UI/UX perspective than a historical MUD. 

It also doesn't mean building more of the same online event platforms we already have, but throwing in some 2D pixel art or traditional 'gamification' markers (leaderboards, badges, etc) or other surface-level signifiers.

What we actually need to take from game design is the understanding of how to use play and playful design to create environments whose architecture encourages and rewards positive social interactions through psychologically satisfying systems. This isn't by any means easy, but I hope the work I've done can show that it's doable!