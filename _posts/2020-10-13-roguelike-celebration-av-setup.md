---
layout: post
title: "Running A Virtual Conference: Roguelike Celebration’s AV Setup"
date: 2020-10-13 12:10
comments: true
---

The [Roguelike Celebration](https://roguelike.club) conference has been running for five years, but two weeks ago marks our first foray into an online-only event!

The most notable thing about this iteration of the event was the [custom MMO-like social space](https://twitter.com/TuckyAalto/status/1312424558767480833) that hosted the event. I'm planning to write plenty about that both from a design and technical standpoint, but today I wanted to talk about something a bit more universally applicable to any online event: the nuts-and-bolts of how we ran our AV setup.

We were a two-day single-track conference, with talks streamed to both Twitch and YouTube (more on that later), and the YouTube stream embedded directly within our custom event platform software. 

This is a technical post for people who will directly be handling AV needs for their own virtual events. I walk through both the technologies we used and the structural/philosophical choices that we made when planning the streaming portion of our event.

To be clear, I was not the person actually operating the stream during the event itself: that honor goes to [Kawa](https://twitter.com/kawaiidragoness) and [Travis](https://twitter.com/MuffiTuffi) on the AV logistics side of things, and [Alexei](https://twitter.com/) and [Noah](https://twitter.com/swartzcr) as emcees/hosts. That said, many of these high-level tooling/process decisions were mine, and the experience I'm sharing about our experience comes from both my personal observations and from speaking with the people who were actively running the stream.

# StreamYard
We used [StreamYard](https://streamyard.com) as our streaming studio. We liked the idea of having a solution that wasn’t reliant on the host’s home Internet connection, and that was easier for both the host and for speakers to deal with than messing around with videoconferencing software.

Having a browser-based tool meant that a conference organizer wasn't running OBS and a videochat client with support for NDI, and that it was easier for us to swap out which organizer was on-duty for technical setup during the event itself.

StreamYard was great. It was easy for us to use, easy for speakers to connect to, and it effortlessly let us stream to both Twitch and YouTube simultaneously.

Throughout our event, we had at least two organizers in StreamYard at all times. We intentionally split out the roles of "emcee" and "technical AV person" into two separate people, largely so that in case of technical issues the emcee could continue to stall and keep the audience occupied (tech permitting!) while the other person fixed the issues. I suspect StreamYard is easy enough to use you could likely get away with only one person, but this worked really well for us. 

We did have a few minor issues with StreamYard:

1. While we were able to integrate our own custom overlays, we didn't have as much control over our display as we would have using something like OBS. It's possible that some of the things we thought we couldn't do (e.g. custom fonts or adding arbitrary text labels) are things that StreamYard is capable of doing, but the documentation wasn't great — we often found ourselves watching YouTube videos from the community when StreamYard's official documentation wasn't helpful.

2. Related to the previous issue: even though we had a human captioner providing live captions, we were unable to embed those directly as closed captions within the stream as we would have been able to with OBS. In our specific case, this was mostly okay: most attendees were watching via our custom social space, where we directly embedded the captions below the stream, and our Twitch and YouTube channels directed people to a website where they could view the captions. 

3. Prerecorded video playback was still reliant on a home internet connection. StreamYard doesn’t let you upload video files and directly play them, so playing a pre-recorded video meant the emcee opening up a Chrome tab with the video file and screen-sharing that tab.

4. For times we played prerecorded videos, the volume was frequently lower than live speakers, and we didn't have a way to dynamically adjust this during the event. In the future, we'd likely take the time to normalize all prerecorded videos before streaming, but it's frustrating StreamYard doesn't appear to have any real-time audio mixing tools.

5. StreamYard's highest paid tier allows you to capture recordings of up to 8 hours long. Our conference had roughly 8 hours of video each day. To avoid unintentionally cutting off our recordings if our schedule went long, we split each day up into two separate StreamYard 'studio' recording instances. Switching over added some minor logistics hassle, and also caused some issues where the YouTube embed widget we were using wasn't capable of automatically switching from the morning to the afternoon video feeds, meaning attendees would occasionally need to refresh their browsers to switch over.

6. StreamYard is a bit finicky when it comes to playing audio over screen-sharing, particularly on MacOS. This wasn't an issue for our specific speaker pool, and is most likely a technical limitation for any browser-based technology, but is worth noting if you're running a particularly multimedia-heavy event.

There are other browser-based streaming services such as  [Restream.io](https://restream.io) and [Stage Ten](https://stageten.tv), but we didn't really spend time looking into them. I'd used StageYard before as a speaker, it was easy to use and affordable, we went with it. 

It's possible one of these alternative services would have given us all of the features and ease-of-use did that StreamYard did, but without some of the other hassles we encountered. I'm not sure. I don't want to speak for my other organizers, but the next time I host an online event, I'll likely investigate to see if that's the case. 

That said, I could also see myself just as easily using StreamYard again, and would heartily recommend it except for those minor caveats.

# Streaming: Twitch vs YouTube
We’re a conference about games and game development. Streaming to Twitch makes sense to us, since that’s where our audience is.

However, Twitch doesn’t offer dynamic bitrate re-encoding of your streams unless you’re a Twitch Partner. This means that viewers on bad Internet connections can’t choose to load your stream at a low bitrate so they can actually watch it. This is exceedingly bad for accessibility!

YouTube does offer this! Our compromise was to stream to both Twitch and YouTube. Our custom social space embedded the YouTube stream, so everyone within the space was watching on YouTube. Even given that, our stream view counts were roughly equal across Twitch and YouTube.

One other thing to note is that we actively wanted to disable chat on both our YouTube and Twitch streams. Our approach was to have all text chat take place in our custom social space, where attendance was limited to people who had chosen to acquire a ticket (whether free or paid) and had agreed to our code of conduct, and where we had active moderation efforts. 

YouTube easily lets you disable live chat on streams. Twitch does not. 

On Twitch, we were able to set chat settings so that the only people who could what were people who had followed our account for more than 3 months. They could only post one message every five minutes, and it could only be emoji. This was functionally fine in practice, but it was frustrating Twitch wouldn’t let us just completely turn chat off, and meant we did have to keep an eye on it.

Which is to say: if you don’t have a solid reason to stream to Twitch (e.g. you’re a games conference), stream to YouTube instead of Twitch.

# Speaker AV Tests
This may be obvious, but it's worth calling out: we scheduled 5-10 minutes for each speaker to pop into the StreamYard a week or so before the event to test out their AV setup and get used to the environment. 

In our case, this was helpful to confirm that each speaker's audio + video situation was sufficient (we had a very small budget to buy speaker equipment when necessary). At a previous online event I spoke at, these AV tests going poorly are what led to the organizers switching from an OBS-based setup to StreamYard. 

StreamYard made this particularly easy. We could give all speakers a link to join the StreamYard instance ahead of time. Since anyone who joins the stream session is put into a 'green room' by default (where they can chat but aren't on-stream) that also made it easy to manage back-to-back AV tests if we were running late.

Speaker AV tests are fairly easy to schedule and make happen, but are essential to making sure things go smoothly during the event itself!

# Prerecording
We asked — but did not require — all speakers to send us recorded videos ahead of time, to use as a backup in case of technical failure. Most speakers did, which I’m extremely grateful for. I’m also grateful we didn’t need to unexpectedly fall back to a backup.

We also made it clear to speakers that, while our default assumption was that speakers would present live, choosing to air a prerecorded video was perfectly fine.

From what I’ve seen as a speaker and conference organizer, experienced public speakers tend to be split pretty evenly about whether they’d prefer to perform live or provide a recorded talk. Some thrive on the adrenaline of knowing there’s a live audience, while others appreciate being able to take the time to record a perfect take or edit after the fact. We wanted both of these groups to do what would make them most comfortable and result in the best possible talks.

At the same time, an aspect of Roguelike Celebration that I really appreciate is that many of our accepted talks tend to come from first-time public speakers. There are certainly exceptions, but in general I’ve found that many inexperienced speakers give better performances live than pre-recorded. This isn’t a knock against anyone in that situation; maintaining high energy levels when you know you’re not speaking to anyone is a skill that often needs to be consciously learned.

Framing live talks as the default of two equally valid options let us nudge our new speakers in the direction that best set them up for success, while still allowing everyone to make their own personal choice as to what would let them give their best performance.

I think this strategy worked out well for us. Worth noting that, even for speakers who opted to use a prerecorded video, we asked (but did not require) that they show up live after their talk for moderated live Q&A.

# Don't Require Speakers to be On-Camera
We had a few speakers who did not want to show their faces. At least one speaker use a SnapChat Camera filter, and another speaker performed as a VTuber with a puppeteered 2D avatar. 

These required more intensive AV setups, but the onus to get that working was generally on the speakers rather than us. Our job was primarily to be supportive: our goal as organizers is to enable speakers to give the best talks they can, and making sure they're comfortable is an important part of that. 

If a speaker is uncomfortable showing their face, I would probably nudge them towards a solution that conveys some sense of body language over disabling their video feed entirely — even the SnapChat Camera solution did a great job of conveying emotion in a way that just audio wouldn't have -— but again, speaker comfort needs to come first.

From a technical standpoint, it's worth noting that StreamYard didn't have any issue with streaming video from virtual camera sources (e.g. SnapChat Camera or an OBS scene exposed as a camera).

# And that was the video portion of our conference!

All in all, the livestreaming portion of our event went remarkably smoothly. At times, we were even _ahead_ of schedule, which I think speaks to how effortless our setup was. 

Hopefully this might be useful to you if you're planning an online event and need to figure out how to handle the technical streaming aspect of your talks!
