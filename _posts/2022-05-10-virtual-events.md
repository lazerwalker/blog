---
layout: post
title: "So you want to run a virtual event"
date: 2022-05-10 11:00
comments: true
---

If you're an event organizer right now, you're in a tough spot. You're desperate to get back to running an in-person event, but you know it isn't quite safe yet. 

Maybe you've seen in-person events in your community lead to large-scale COVID outbreaks or even deaths, and that terrifies you. 

Maybe your planning team disagrees on what an acceptable level of COVID safety is, or you don't have the resources to provide what you believe to be adequate safety.

Even if you could run an event in-person, you're worried about losing the accessibility of a fully-remote event for attendees who are immunocompromised, or who live in far-off places and can't reasonably travel.

Whatever reason, you need an online event. But you're also justifiably worried, because online events tend to suck. And now that people in a lot of the world are seeing their friends  in-person and spending time in places that aren't their homes, the prospect of spending a day or a weekend or a week plastered to a Twitch stream seems even more unpleasant than it did in 2020. 

How the heck do you actually throw a virtual event worth attending?

## I don't have the answers
Unfortunately, this isn't a "how-to" guide. If I could give you a concrete checklist for how to throw an online event that didn't suck, I would!

It's also hard to give concrete suggestions since it's so dependent on your conference's audience, and how "experimental" a space is appropriate for you. I've attended exciting, creative, community-driven in-person conferences hoested in found spaces that needed major modifications to work as event venues (I love to tell the story of the [Berlin games festival](https://amaze-berlin.de) where the two talk tracks where "in the karate dojo" and "on-stage at the combination nightclub and pool"). I've also attended plenty of corporate conferences in hotel ballrooms or city-owned convention centers. 

The former has a lot of leeway to get experimental with online events, while the latter is going to have a harder time convincing attendees to try something different. Knowing your audience is key. A lot of the advice in this article is more focused on people who _do_ have room to explore, but even if you're restricted to using a relatively-buttoned-up turnkey enterprise event platform, there are still usually ways you can nudge the social design of your space one way or another.

If it's not obvious, this article is also focused more on events that look like conferences or festivals — the sort of event where an in-person event would typically be centered around one or more tracks of talks. Designing other types of events, like parties, face all of the same conceptual design challenges, but a lot of the specific tools at your disposal may be different.

**The point of this piece is really to convey that designing a virtual event is, in fact, a design problem, and a deeply complex and largely unsolved one at that.** I'm hoping I can point you in the right direction for some of the questions you should be asking, and some of the design considerations that should be front-of-mind as you start to create an event for your community.

## The first question: do you actually want to throw a live event?

A question I ask to a lot of event organizers is "why are you producing a livestream instead of a YouTube playlist?" 

GitHub's most recent [GitHub Universe conference](https://githubuniverse.com/) completely bypassed the idea of live talks: it being a "two-day event" simply meant that each day featured a new YouTube playlist of new talks to watch asynchronously, plus a fifteen minute "keynote" previewing that day's new talks.

There are benefits to running a live event. A lot of people won't go out of their way to watch a half-hour talk on YouTube, even if it's directly applicable to their interests or professional development. A live conference feeling like a "happening" or a "moment" can give people the push they need to make time in their busy schedule for something they would enjoy and benefit from.

On the other hand, it's a big ask to get people to attend a synchronous virtual conference, especially as more in-person activities become allowed. People feel guilty taking time off work to attend a weekday virtual conference, and don't really disconnect from work when they do. For weekend events, they're hesitant to spend their limited free time staring at a computer screen instead of doing, well, literally anything else. This is especially true if your event has little to no meaningful networking or social interaction driving a sense that people will miss out on something valuable if they just catch the talks on YouTube after the fact.

There's no single correct answer here, but whether you throw a live virtual event or something more asynchronous, be sure to have a coherent reason why that's the correct choice for your community and attendees.


## Your event needs to be an event

Why do people attend conferences or other events? They might say it's the talks, or the socializing and networking opportunities in the "hallway track", or for a certain class of professional events they might be honest and say "it's a free work-sponsored vacation".

Any reason is valid. But the real underlying reason people attend your event, instead of finding another way to achieve those goals, is precisely because it's an "event". It's the act of traveling to an in-person conference that allows your brain to shift into a new headspace where you're receptive to new ideas or meeting new people. It's why companies run "off-sites" for big-picture brainstorming: that context shift is essential.

It's hard to get this for an event that people attend from the comfort of their own home. It's even more difficult when you're asking people to use software — Discord, Slack, Zoom, Twitch — that they already use in their day jobs and social lives. There's no sense of moving to a new space. It's no wonder people find it hard to disconnect from their work when they're sitting at their work desk and using their work software!

## How do you create that sense of place?

This is the million-dollar question.

With [Roguelike Celebration](https://roguelike.club), a game design conference I run, our answer was a [custom-built social space](https://blog.lazerwalker.com/2020/10/22/virtual-events-and-game-design.html) blending design elements of chat apps like Discord and Slack with MUDs, the text-based precursors to MMORPGs. Consistent feedback we've gotten across two years of events is that, despite being a text-based chat space, attendees feel a sense of physical presence. They describe coming back year after year as having the same feeling as going back to an in-person venue, and they tend to use a lot of the same language that VR enthusiasts use around "presence" despite it being a text-only space. That's really cool!

I wouldn't necessarily start with trying to build your own custom event platform like we did, even if you have the resources. Instead, get creative: what existing tech platforms can you repurpose for your event that will help it feel special? 

Online spatial chat platforms like [Gather Town](https://gather.town) or [Skittish](https://skittish.com) can be nice, but require a lot of customization (I'll talk more about them later!). A lot of event organizers I've spoken with lately are interested in repurposing existing online spaces — like, say, finding a free MMO or online game that can serve as a social space — which I think is a really interesting path to explore, even if I haven't seen concrete success there. 

Finding the right "found space" can also be tricky. I've seen events flop in spaces like Second Life, as anything that's 3D rather than 2D will have accessibility barriers to basic things like navigation unless somebody is already familiar with 3D games. I've seen events held in Roblox fall over from a technical standpoint, as its networking is generally extremely robust but has scaling issues if you want more than a dozen or so people in your space at once. I mention these not to say "X tool is bad!", but more to emphasize how important it is to test a potential space to the extent you can before committing to it.[^1]

If you have access to _some_ development resources, a nice middle-ground might be building on top of existing open-source projects. Roguelike Celebration's social space is [on GitHub](https://github.com/roguelike-celebration/azure-mud), as is [LIKELIKE Online](https://github.com/molleindustria/likelike-online), a 2D pixel art gallery space. If you go down this route, it's worth emphasizing how much custom-built event spaces are, in fact, built for their specific contexts, and how well they could work for your event depends on how much context overlap there is. I don't know how well Roguelike Celebration's setup would work for an audience that doesn't get immediately excited at the idea of a text-only world. Similarly, LIKELIKE does a phenomenal job of replicating the vibes of an art gallery opening party, where attendees can vibe with the energy of the space and briefly say hi to people they know, but the way it "feels" like a loud noisy party means it'd be a poor fit for a networking-focused "hallway track" where you want people to be able to have in-depth conversations with each other.

### Case Study: Deserted Island DevOps

It's worth noting that you can create this sense of place without necessarily providing interactivity. I want to talk about a really clever and resourceful example: [Deserted Island DevOps](https://desertedislanddevops.com/). A conference that first took place in April 2020, at the start of the pandemic and the height of the popularity of Animal Crossing: New Horizons for the Nintendo Switch, it's a conference that "took place in Animal Crossing".

Now, if you've played Animal Crossing, you know that "a conference in Animal Crossing" would be unwieldy and impractical. Animal Crossing has great multiplayer features, but it allows a maximum of 8 people in the same island, and chat options are limited. 

In practical terms, Deserted Island DevOps was a "boring" virtual conference: it was little more than a Twitch stream and an associated Discord. The "Animal Crossing" piece came from the Twitch stream itself: a video feed of an Animal Crossing instance, showing the speaker's Animal Crossing avatar (they had full control over their avatar's appearance and could trigger custom emote animations) and their slides composited into the scene.

The event was a huge success, with nearly 12,000 live views over the course of the weekend, and a lot of buzz on social media for how innovative their approach was. I think a huge take-away from Deserted Island DevOps is that creating a sense of _place_ doesn't necessarily mean creating a novel interactive space people can navigate. Sometimes sufficiently evocative theming can be enough!

## To videochat or not to videochat?

A thing I have learned is that people have drastically different opinions about videochat. Some people desperately crave the ability to get literal "face time" with other event attendees. Others can't stand the idea of having to turn on their webcam to talk to strangers. Similarly, some people easily prefer audio-only chat to videochat, while others can't stand the loss of social cues that comes from having audio but not video. I'd urge you to make sure the design of your virtual event caters equally to all of these groups.

Videochat is a high-trust activity. People in videochat are more vulnerable to harassment than text chat, and moderation is also trickier when you don't have a perfect record of everything said. Different communities and sets of conference attendees have different levels of trust; while there are plenty of trust and safety tools you can use to mitigate issues once your event has started, I'd urge you to both think about how to cultivate as healthy a community as you can before your event begins, and also approach designing videochat at your event with an honest eye towards where your event's community falls on the trust spectrum.

In the past, I assumed the ideal was an event where attendees could freely choose to consensually escalate from text chat to audio or video at any point during the conference. For Roguelike Celebration 2021, we built out our own custom videochat, and spent a great deal of time designing an exceptionally thoughtful videochat system that did just that, seamlessly integrating videochat and text chat in our social space. To be blunt, our attempt was broadly a failure, with the focused exception of using our videochat for post-talk speaker Q&A breakout rooms. 
	
Humans instinctively prioritize paying attention to people with higher-fidelity modes of communication. I don't know how you design videochat that doesn't give preferential treatment to video users over audio or text users. This is definitely true if using an off-the-shelf event platform or videochat tool, but even with a custom-built solution it's an unsolved problem. And that's even before tackling issues of Zoom fatigue; even people who love videochat will get tired if they stay on video for too long.

### Videochat as a focused tool
Instead, I'd encourage you to think of videochat as a focused tool you can apply at specific times during your event. A lot of people who might not want to spend 8 hours on a call would probably love to spend a focused hour or two with a higher-fidelity chance to connect with other attendees. If these sessions are time-limited and opt-in, it's also easier to feel comfortable prioritizing videochat users over others in these sessions.

One specific hard problem to design for is allowing people to "preview" conversations. In real life, it's easy for someone to hover at the outside of a conversation circle before choosing to engage or find a different conversation. Most online tools do a poor job of recreating that dynamic — joining a Zoom call and then leaving ten seconds later feels socially awkward, as does walking up to a chat circle in a tool like Gather Town and then leaving. There are ways to minimize that awkwardness can with either technical or social solutions, but it's a hard problem you need to think about and actively solve for.

There are many ways to design focused video time. At Roguelike Celebration, we do "unconferencing" sessions, where people can self-select into Zoom rooms based on conversation topics proposed by attendees. I've also seen a lot of success with "speed dating"-style breakout rooms,  where people are placed in random conversation groups for a preset period of time before being automatically split up and reformed into new groups. 

I don't have a lot of concrete advice around unconferencing other than having decent tools to allow proposing and upvoting topics (and having an answer to the "how to poke your head into a room" problem), but it is a model that works really well for us.

### Videochat breakout rooms / "speed dating" / "coffee chats"

If you want to try a "speed dating" or "coffee chat" model, that's typically easy to implement using the "breakout room" functionality of most commercial videochat software. The rigid, predictable structure makes it convenient to make new people, as it hand-waves over a lot of the awkwardness of how to start a conversation with someone in the first place. 

The tricky thing is this pattern really requires you have a high-trust environment, even more than other videochat techniques. Because you can't simply leave a conversation while it's happening, it's easy for underrepresented groups to get frustrated if they feel like they aren't being listened to. You probably won't receive formal code of conduct reports, people will just quietly stop participating. While there are social tools you can use to try to shape these conversations to be healthy,  the success of a session like this really hinges on your attendees being kind, respectful, and generous. If your community is on the lower end of the trust spectrum, this specific technique might not be right for your event.

If you do think that sort of "coffee chat" is appropriate for your community, I'd recommend groups of 3-4 people, 5 minute chats, and some sort of formal or informal structure for how to break the ice in each chat. 1-on-1 chats and longer durations can both work in higher-trust environments, but most of the time you want to aggressively optimize for mitigating just how miserable it is to be stuck in a bad conversation.

Ice-breakers depend a lot on the context. I've seen professional networking sessions use a convention where each person starts by giving a 30-second intro to themselves, and I've seen people doing this in context of a creative retreat naturally lead with "so, what are you working on?". 

### Facilitators: you probably need them

Regardless of what your videochat structure looks like, if you plan to have more than 5 or so people in a single videochat, you probably want facilitators to help keep the conversation moving. In work contexts, someone usually runs the meeting and plays this role; in social Zoom chats with friends, someone probably informally picks up this mantle. At an event where you are hoping that strangers or pseudo-strangers will talk to each other, making sure that you have a volunteer or staff member to play this role (instead of hoping an attendee might) is a good way to stack the deck and make sure things go well.

This obviously depends a lot on your format. If you're using a spatial chat tool, it might be awkward to have people whose explicit job is to go around and start conversations. But if you're going to invest in making videochat work for your event, it's worth thinking about how having a few human facilitators can help ensure the experience is a positive one.

## How to create social interaction

At in-person events, there's a wide range of social interaction people might take part in, with varying levels of interactivity or room for freeform conversation. Sitting down to discuss Serious Topics with someone one-on-one is different from making small talk over the cheese table is different from playing a game of cards where the majority of the space in the conversation is taken up by the logistics of the game itself.

People are very good at subconsciously navigating these varied spaces and choosing the form of interaction for them that's right for them. But this requires an event that provides that wide variety of interactions. If your event just provides a single way to "network", it'll feel flat, and a large number of your attendees won't feel comfortable chatting.

Like so much else I've been talking about, I sadly can't give you a checklist or playbook to just implement. Figuring out how to provide that range of activities is so highly dependent on both your audience and on your event platform. It's also really hard to talk about! I don't think Roguelike Celebration is perfect at this yet, but it may be instructive for me to outline some of the conversation opportunities we intentionally create or support. Going from most involved to least involved:

* Each day, we host "unconferencing" sessions, where people can propose topics (generally design or technical subjects) to discuss in focused Zoom calls
* After each block of talks, speakers can optionally break out into a dedicated room for Q&A with attendees. Generally, the speaker is on a videocall while other attendees use text chat
* During the mainstage talks, we encourage a vibrant Twitch-style chat. With our audience, this generally leads to a good blend of insightful discussion/commentary and silly memes
* During the talks, people can also submit and upvote questions to be asked during any formal moderated Q&A time left at the end of a session (separate from the speaker breakout rooms). This gives people a chance to contribute to the discussion who are overwhelmed by the pace of the real-time chat
* During unstructured breaks, we've seen a pattern of people running their own playful or game-like activities in the space, ranging from running short tabletop RPG sessions to someone hosting a fortune-telling table
* In 2021, we introduced a short puzzle hunt / chain of riddles, which gave people an activity they could either do solo or team up with others and ask for help on
* Our space has consistently included a number of "fidget toys": objects you can pick up and carry with you, magical potions that append an emoji to your name, ways to interact with the space and see a random text generator do something silly. These give you an easy way to strike up a conversation with someone else by, say, commenting on their emoji, or asking where they got their item, and also give you a way to passively do something in the space alongside someone else without talking.

	It's worth calling out that our attendees spontaneously playing formal games and doing fortune tellings is not something to plan for. In most cases, that sort of attendee self-organizing doesn't happen, or happens relatively infrequently. If you want to try to encourage people to play online multiplayer party games together (which is a great form of social interaction!) I'd put it upon yourself as an organizer to make it happen. It's a lot easier to get attendees to jump into a game of Jackbox, say, if a facilitator actively schedules it, sets up the game, and tells people where to show up, rather than hoping an attendee will spontaneously choose to do all that work.

If this set of problems is something you're interested in solving or diving deeper on, I'd also recommend you read my [earlier article about Roguelike Celebration](https://blog.lazerwalker.com/2020/10/22/virtual-events-and-game-design.html), as I go into a few other topics not covered here. Kate Compton's [talk about technology design for social creativity](https://www.youtube.com/watch?v=3HWwSbnkg4I) has also been formative in my thinking.

## Purpose-built spatial event platforms

I've seen a lot of interest in online event platforms specifically built to be fun spaces that lean on playfulness to provide an alternative to traditional video calls. There are a ton of these "spatial" event platforms: [Gather Town](https://gather.town) is perhaps the best-known, but I have familiarity with [Skittish](https://skittish.com), [Wonder](https://www.wonder.me/), and [Bramble](https://www.bramble.live/), and you could easily find a dozen more. 

They broadly share similar featuresets: each attendee controls an individual avatar in a custom space (almost always 2D, or 2D movement within a 3D space, often with a retro pixel-art aesthetic), and when you walk close to another attendee, you can see their webcam feed and/or hear them speak via microphone. The core idea behind these sorts of platforms is that spatial audio/videochat recreates an aspect of in-person events, where you can walk up to somebody and have a conversation with them without it being a giant unwieldy video call.

Different platforms differentiate themselves through things like their default aesthetic, their editing tools, whether you can host a live presentation in the space, the specifics of their audio/videochat, and things like that. But the core value proposition is often broadly similar. I often see these either adopted as the core platform for an event, or just used as the venue for a specific scheduled 1-2 hour "social hour" or networking session.

If you're considering one of these tools, the main thing I would urge you is to recognize them as just that: tools. Just because you may be using an event platform that allows people to walk up to each other and strike up a conversation, that doesn't mean they will unless encouraged to do so through thoughtful social design. You absolutely can build a space that accomplishes the sort of goals I set out above using tools like these, but in most cases I'd recommend thinking of them as jumping-off points to build on rather than ready-made solutions that will solve the hard social problems for you. This holds true whether you're looking to hold a "social hour" in tools like this or are hoping to use them as your primary event platform.

The linguistics conference LingComm has a great series of articles about running their 2021 online event, most notably one about [the design of their Gather space](https://lingcomm.org/2021/06/28/hosting-online-conferences-for-building-community-the-case-of-lingcomm21/) (also to read: LingComm organizer Gretchen McCulloch's [Wired article](https://www.wired.com/story/zoom-parties-proximity-chat/) about these sorts of tools). If you're looking to use one of these readymade spatial event platforms, I think LingComm is a great example of the sort of care and effort you need to put into designing your space (disclaimer: both of those articles liberally cite my work with Roguelike Celebration :P)

Counter-intuitively, you may also have more success using one of these tools that is less popular. As I've discussed, a big part of the value of using a "non-traditional" event platform is the novelty of a space affording a context shift. If other events in your community regularly use one of these event platforms, it may already feel "same-y" to attendees. In other professional technical contexts, I often advise people to not make technology choices based on what's new and shiny, but that may be exactly what you want here.


### Sidenote: VR spaces

One specific sub-flavor of this sort of chat tool you might encounter are VR spaces like [AltSpace](https://altvr.com/), [VRChat](https://hello.vrchat.com/), or [Mozilla Hubs](https://hubs.mozilla.com/) that are primarily focused on VR but also usually support flat displays or smartphones.

My advice here is simple: this is a great option if you're working with an audience that is already intimately familiar with VR or 3D virtual worlds. Otherwise, the technical barriers of getting people onboarded in a first-person 3D space are too large. You'll waste your time and your attendees will be frustrated.

If you do happen to be running an event for a VR audience, I urge you to explore your options for yourself, but my informal opinion is that AltSpace is best for large events where thousands of people will watch a single presenter and you need to shard audience instances, while Mozilla Hubs is the most flexible (and the most accessible across a wide range of non-VR devices) for smaller and more informal events.

## How do you schedule it?

One of the biggest strengths of virtual events is that you can welcome attendees from all over the world without requiring expensive travel. Supporting that through a schedule that's equally inclusive is surprisingly difficult. It's easy to schedule an in-person conference: your conference day aligns with the working day. That doesn't necessarily make sense when all of your attendees are in different time zones.

I've seen two common approaches here, depending on your resources.

### 24-hour conference

One approach is to schedule a "24-hour conference". No matter what time zone an attendee is in, there will be something happening during the day their time. This is great for the way it doesn't center a specific region: it feels conceptually more inclusive, and concretely makes it easier for you to attract audiences outside of the geographic regions you usually operate in. 

It's also difficult to pull off, requiring having strong geographic diversity for both speakers and conference staff to make sure that all times feel equal. If you go down this route, I'd also consider how you can intentionally design your schedule during common overlap times to encourage groups to mingle, so it doesn't just feel like your conference has different "shifts" where people only interact with people from the same region as them. Similarly, if you run a 24-hour event but don't actually have a globally diverse pool of attendees, you'll end up with "dead" periods of time, which also isn't great. A global-first event schedule needs to be accompanied by a global-first marketing plan.

### A core time zone
The alternative is to pick a "core" time zone and schedule around that. Roguelike Celebration, for example, is scheduled around Pacific time, since we were historically hosted in-person in San Francisco. This is much easier for us to staff, although requires careful consideration to still be as accessible as possible. We need to be as accommodating as possible to speaker schedule requests, so someone isn't stuck speaking in the middle of the night their time. 

We also consciously schedule our event so that people in non-Americas time zones can experience as diverse a sample of content as possible during their daylight-hours overlap. For example, we host "unconferencing" sessions each day, where attendees can post topics they'd like to discuss and then hop into a Zoom call with other attendees. We intentionally schedule these at different times each day — typically one in the morning and one in the afternoon — to try to maximize the chance that someone in Europe or the APAC region can at least attend one of them.

There's no one "correct" answer here. Maximizing the global accessibility of your schedule is a tricky problem that cuts across almost all of your other planning concerns.


## Hybrid Events

Maybe you're _really_ itching to run an in-person event, and you think it's possible to do _something_ small, alongside a virtual event.

I have a hard truth for you. It's absolutely possible to run a successful "hybrid event", but it requires having a successful virtual event as a baseline. If you start from the standpoint of running a good in-person event, and attach a virtual component to it, virtual attendees will correctly recognize that they're an after-thought. 

You need to start by designing a top-tier virtual event experience, and then from there figure out how to augment that experience with in-person moments. If you're not taking that approach, you're not running a "hybrid event", you're running an in-person event with a secondary livestream.

It hasn't happened yet, and I'm deeply critical of their almost total lack of COVID safeguards, but Apple's upcoming [WWDC developer conference](https://developer.apple.com/wwdc22/) tentatively seems like a great example of how to do this right. WWDC is a weeklong virtual event; separately, there's a one-day in-person event you can submit a request to attend, that primarily consists of a viewing party for the WWDC keynote and Platform State of the Union speech as well as some tours of additional on-site Apple spaces. Presumably the keynote and SOTU are still being produced as livestream-first events, but allowing some people to capture the magic of an in-person live keynote experience (which was previously a tentpole of in-person WWDC) seems like tentatively a good way to allow some in-person camaraderie while not creating too much FOMO for attendees of an otherwise virtual-first event.

## Odds and ends
There are a lot of other important aspects to running a virtual event, but talking about them starts to become more logisical than conceptual. I could write a whole blog point about each of these (and have in many cases!) but a few quick things to keep in mind:

* Your event should ideally have live captions, provided by a human captioner. I've [written about the logistics of this](https://blog.lazerwalker.com/2020/07/20/captions). The short version is that it requires budgeting, but relatively little work, and is infinitely better than using AI-generated captions. If you can't afford a human captioner, make sure you have automated captions.

* Make sure your schedule is easy to understand regardless of whether someone is in the same time zone as the organizers. I recommend investing in a little bit of front-end JavaScript code so your website automatically shows times in each attendee's local time zone.

* Your virtual event is likely more accessible due to people being able to attend worldwide, but that doesn't mean it's financially accessible. What you consider a "cheap" ticket might not be that for people elsewhere in the world. I've seen a handful of conferences adopt pay-what-you-want pricing — Roguelike Celebration has suggested tiers including "pay for yourself", "pay for yourself and someone else", and "I can't afford to pay". Our revenue has been roughly the same as it was before  introducing that PWYW structure, and I've heard the same thing from other organizers using the same pricing plan.

* How to technically host remote talks is an extremely deep subject (that [I've written about](https://blog.lazerwalker.com/2020/10/13/roguelike-celebration-av-setup.html)!), but big picture, have a dedicated AV person on duty instead of just your MC, and use a hosted all-in-one platform (like [Streamyard](https://streamyard.com)) rather than fiddling with your own OBS setup. Run AV tests beforehand with every speaker, allow them to pre-record if they'd prefer, and be respectful that speakers may have valid reasons to not show their face on-camera. Ideally have a budget to pay for cameras/mics for those who need them.

* If the thousands of words you've just read weren't enough from me: aside from the various posts of mine I've linked throughout this piece, I also wrote about [building a better hallway track](https://blog.lazerwalker.com/2020/07/09/virtual-worlds.html) (this was the earliest design thinking that eventually led to the Roguelike Celebration space) as well as [a list of questions to ask yourself](https://blog.lazerwalker.com/2021/01/04/social-design-questions.html) when designing a synchronous online social space.

I hope this massive brain-dump was helpful! If anything in here sparks inspiration for you to do something different in your own virtual event planning, I'd love to hear about it — my [Twitter DMs](https://twitter.com/lazerwalker) are open.

[^1]: A quick hot tip to share the sort of brainspace I'm currently in: I'm convinced, for the right experimental event, [BYOND](http://www.byond.com/) would be an incredible tool to build a custom space. It's an early-2000s low-code/no-code tool for building online multiplayer games, most notably [Space Station 13](https://spacestation13.com/). Getting the editor to run on a modern Windows 11 PC can be a challenge, but I'd _love_ to see an event run in a custom-built BYOND space.
