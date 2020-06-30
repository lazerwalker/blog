---
layout: post
title: "What is Spatial Audio, Why Does it Matter, and What's Apple's Plan?"
date: 2020-06-30 12:00
comments: true
---

At WWDC 2020, Apple announced that iOS apps will soon be able to use motion data coming from your AirPods Pro to enable head-tracked spatial audio. They talked about this largely in context of playing movies with multi-channel surround sound, but that's probably the least interesting application of spatial audio.

As someone who's been working in the field for a long time — my research at the MIT Media Lab in 2015 and 2016 focused on location-based storytelling in public spaces using spatial audio — I wanted to try to give some context around why this is interesting and what it might enable.

## What is spatial/positional audio?

Spatial or positional audio (these terms are typically used interchangeably) lets you position sounds anywhere in 3D space. Instead of just thinking about sound engineering at the level of "is this to the listener's left, right, or neither?" as you would with normal stereo sound, you can place specific sounds at specific 3D locations around the listener: say, a sound that's in front of you, a little bit to the left, and a meter or two above head/ear height.

If that sounds a lot like surround sound, you're not wrong, but the underlying technology is different. Surround sound systems play audio out of speakers that are placed in different physical locations. To play a sound that sounds like it's behind you and to the right, you use a speaker that is literally behind you and to the right.

The sort of spatial audio we're talking about is (usually, but not always) concerned with producing sound that is situated precisely in 3D space despite coming out of a pair of normal headphones.

## How does spatial audio work?

Let's talk about how humans normally hear sounds in the real world.

If a loud noise happens directly to your left, those sound waves will reach both your left and right ears. But while they have a pretty direct route into your left ear, your right ear will receive them after they've passed through and been shaped by your skull, your brain, and pretty much everything else in there.

Humans — specifically, our brains, inner ears, and outer ears working together — are really good at processing the difference in these sound waves and transforming those raw signals into your conscious mind saying "ah yeah, that sound is coming from over there".

To produce spatial audio that lets you hear things in precise 3D locations through a set of headphones, the audio coming out of each headphone ear needs to essentially recreate the sound attenuation that happens naturally so you can to trick your low-level auditory systems into thinking the sound is coming from someplace else.

## How does do you produce spatial audio using analog methods?

The traditional way of producing binaural audio recordings involves taking two microphones and sticking them in the 'ears' of a mannequin head that's been designed to roughly match the density of a human head. Done right, this gives you a stereo audio recording that truly does capture the 3D soundscape as it was recorded.

The audio walks by sound artist Janet Cardiff are a great example of these traditional analog methods. If you want to get a sense of how effective this technique can be, grab a pair of headphones and listen to a few minutes of her NYC audio walk [Her Long-Black Hair](https://soundcloud.com/incredibleworksofart/sets/janet-cardiff).

## Using digital techniques for spatial audio

Manually setting up two microphones and a test dummy is a lot of work. Modern audio production techniques typically involve math instead. Specifically, they use a set of models known as Head-Related Transfer Functions (HRTF) that describe the transformation that occurs when a "pure" sound is attenuated in such a way so as to mimic what a specific ear would hear.

Although specific HRTFs theoretically vary from person to person (all of our bodies are different!), in practice researchers have generated a few different algorithms that will work well for most situations. If you're using HRTF as a programmer or sound engineer, in most cases you'll just see "HRTF" as an option you can enable and that's really the extent to which you need to think about it.

## How do you adapt to the listener?

Whether you're working with analog binaural recordings or digital tools that can apply HRTF, the results are usually stereo audio files that sound impressively like they're positioned in real space.

But they're still static recordings. Let's say that a sound is directly behind you. If you turn 90 degrees to your left, you'd expect that sound is now directy to your left. But because the audio recording was made so that sound is "behind" you, it will turn along with you, breaking the illusion.

This is where being able to create spatial audio in software is valuable. If you have some way of tracking the position of the listener's head, you can dynamically adjust your sound generation in real-time to keep a sound source fixed in the listener's concept of real-world space.

Right now, the main commercial application of something like this is VR and AR headsets. Since they already have high-quality head tracking data for graphics rendering, using that same data for positional audio is a no-brainer.

# Where AirPods Pro come in

Given all of that, hopefully you can see how adding spatial audio features to AirPods Pro might work.

Apple already offers an API for producing spatial audio with HRTF, both integrated into ARKit for AR experiences and in the more general-purpose AVFoundation library. This has actually been part of iOS since 2014!

With iOS 14, Apple is adding a set of new APIs to use the motion sensors already in AirPods Pro to provide head-tracking, letting developers build positional audio experiences that are aware of how the listener is moving their head.

This isn't a completely new concept — until recently, Bose maintained a similar platform for head-tracked spatial audio using certain Bose headphone models and a third-party smartphone SDK — but being supported at a first-party system level, with Apple's incredibly popular headphones, will almost certainly help this see wider use than Bose's SDK.

## The audio version of ARKit

You could technically build visual AR apps without using an AR framework like ARKit or ARCore. It's not a lot of work to show a live camera feed in a mobile app, and then overlay a 3D model on top of it. But unless you're doing a lot of manual computer vision work, you're not going to have the world awareness to keep that object's position fixed in real space as the user moves the phone around.

Head tracking for spatial audio is similar. Prior to this announcement, you could easily make experiences for iOS that play positional 3D audio soundscapes through users' headphones. But without head tracking, they lack an awareness of and connection to the physical world, and it's not possible to make the sounds feel like they're fixed in a concrete real-world position. This new API solves that.

## What does this look like from a technical standpoint?

As of the writing of this piece, Apple's APIs aren't ready for public consumption. There's a new [headphone motion API](https://developer.apple.com/documentation/coremotion/cmheadphonemotionmanager), and a new as-yet-unused [configuration option for different spatialization algorithms](https://developer.apple.com/documentation/audiounit/audio_unit_properties/spatialization_algorithms) that seems unconnected to the existing AVFoundation APIs.

The latter suggests to me that Apple may release a higher-level system that, say, automatically adds head-tracked spatial audio to any apps already playing audio through ARKit. I suspect they will heavily encourage developers to use ARKit when appropriate, as augmenting headphone motion data with camera-based world tracking will likely provide better tracking results.

That said, once new AirPods Pro firmware has been released that support sending motion data, the headphone motion manager will be enough for interested developers to dive in and start building spatial audio experiences.

Four years ago, I built some [quick experiments](https://github.com/lazerwalker/ios-3d-audio-test) using the iPhone's built-in accelerometer and gyroscope to control a spatial audio scene generated using Apple's existing AVFoundation spatial audio APIs. The code to wire up the two was straight-forward back then, and a similar approach should work just as well when it's using motion data coming from the headphones instead of from the phone itself.

# Why does this matter?

This is all well and good. But what does head-tracked spatial audio actually enable? Providing a more immersive experience for films or 3D games, as Apple suggested, is a natural use case, but far from the most interesting one.

What's difficult about answering this question is that there isn't really yet a well-established field of design for building audio-only real-world experiences that take advantage of positional audio. Existing audio-only platforms like voice assistants don't really have a concept of grounding an audio experience in the physical world; even the people building rich gaming experiences for those platforms don't have the clearest answer of how spatiality might change things.

Based on my experience working with spatial audio, there are at least a few broad classes of potential applications that really excite me. This is far from an exhaustive list, but here's a taste of the sorts of experiences we might see as spatial audio becomes more of a thing:

## Wayfinding

One of the first usecases people tend to think of for spatial audio are helping people navigate the world. Microsoft has already released an app called [Soundscape](https://www.microsoft.com/en-us/research/product/soundscape/) that uses binaural audio to help people who are blind or have low vision to navigate the world.

It's easy to imagine turn-by-turn navigation apps adding in support for spatial audio cues, and interaction patterns such as "follow this sound that keeps moving in the direction you should walk" becoming commonplace.

As Apple improves their indoor location technology, this could also easily become a big part of making indoor wayfinding viable before they ship AR glasses, since the ARKit model of "hold your phone out in front of you while you walk through a space" is both socially and physically awkward.

## Improving existing audio content

If you speak to anyone who's worked on a social platform for VR, they will be quick to point out how much of a difference spatial audio makes in fostering natural voice conversations. When human voices are mapped to distinct physical locations, it's like a switch is flipped in the brain that makes it easier to differentiate similar-sounding voices, even if you're on a platform that doesn't have great lip-syncing or other visual ways to indicate who's speaking.

It wouldn't surprise me to see applications like group voice chat apps or even podcast apps embrace spatial audio as a way to make conversation feel more natural and easier to make sense of at a subconscious level.

## Real-world gaming and playful experiences

One of the projects that resulted from my MIT research into spatial audio was a [site-specific generative poetry walk](https://www.youtube.com/watch?v=swQ338aOGm0) built for a park in San Francisco. Being built for consumer iPhones in 2016 meant it doesn't use head tracking for its positional audio, but key to the piece are the binaural audio soundscapes that subtly fade in depending on where in the park you are.

If you're in the main grassy field in the park, you may hear kids laughing and playing off in the distance, and you won't really be sure whether they exist in the real world or just in the audio; the cacophany of birds chirping as you enter the fenced-off community garden create a sense of magic and connection to nature in a visually stunning space.

The [Janet Cardiff audio walk](https://soundcloud.com/incredibleworksofart/sets/janet-cardiff) I mentioned earlier does similar magic tricks with (also non-head-tracked) positional audio. You'll hear a couple arguing behind you, or police sirens going off on the street outside the park, and not be sure whether it's reality or fiction.

Cardiff applies a ton of incredibly subtle psychological tricks to prevent you from turning your head and breaking the illusion of the static baked-in binaural audio. This means her work is generally in a league of its own, as this sort of work is so difficult to replicate without her sheer experience and talent.

Having readily-available consumer head-tracked audio means making these sorts of experiences will be so much more accessible to creators of all types, not just ones with extensive experience in traditional binaural audio production.

To be clear, I think the future of games and playful experiences focused on spatial AR audio isn't in extending games like Pokémon Go to be more "immersive", but in taking design cues from live-action role-playing and immersive theatre design communities. My design goal for my poetry walk was to create something that encourages players to appreciate the mundane beauty of a public space in their neighborhood, blurring reality with fiction and make-believe to elevate reality into something that feels magical.

Positional audio is so much more powerful — and so much cheaper to produce — than current-day 3D visual AR at causing that sort of emotional reaction in players. Apple helping to make head-tracked positional audio mainstream could bring on a waterfall of beautiful hyperlocal audio experiences.

# So what's the takeaway?

I feel like I'm standing over here, wildly waving my arms at everyone to pay attention to my favorite pet technology that's finally on the verge of becoming mainstream. But it's true!

I think spatial audio in general is a much more powerful technology than a lot of people give it credit for, but good head-tracking available in consumer hardware is the piece that's been missing for it to find more widespread appeal. By piggy-backing off of existing popular headphones, Apple is well-positioned to make spatial audio tech explode in a way that it hasn't before.

I'm so excited to see what people make if this, and can't wait to dive in more as Apple updates the AirPods Pro firmware and makes beta API access available. Let me know if you're working on something cool or have cool ideas for ways to use spatial audio tech!
