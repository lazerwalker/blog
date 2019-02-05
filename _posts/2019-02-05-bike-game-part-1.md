---
layout: post
title: "Making A Cycling Game! Part One: Brainstorming"
date: 2019-02-05 10:00
comments: true
categories: 
---

To make sure I get plenty of exercise during cold and dreary Berlin winters, I recently picked up a [smart bike trainer](https://tacx.com/product/vortex-smart/), a device that turns my bicyle into a Bluetooth-enabled stationary bike. It connects to my iPad, at which point various apps can both access its cadence and speed sensors (how quickly I'm pedaling) and dynamically change the resistance (how hard it is to pedal). It's like the nerdier version of a [Peloton](https://www.onepeloton.com) exercise bike. 


<center style='margin: 2em'>
    <a href="/images/smartbike.jpg"><img src="/images/smartbike.jpg" alt="Tacx Vortex Smart bike trainer" style='max-height: 400px'></a>
</center>

There's a small but healthy ecosystem of apps and games built around hardware like this. A personal favorite is [Zwift](https://zwift.com), an MMO-like experience where you go for virtual rides with other real players. I like Zwift and its ilk, but they're all much more "cycling nerd training tool" than "fun game". 

As a game designer, I'm interested in fixing that!

I help organize [alt.ctrl.PARTY](https://alt.ctrl.party), an annual party during the Game Developer's Conference celebrating games with nontraditional physical controls. We haven't started planning this year's lineup yet, but I was thinking it would be awesome to be able to showcase a game there that uses a bicycle as a controller. 

In tandem (hah!) with designing and prototyping potential cycling games, I thought it'd be a productive exercise to document my process. The nature of game development means that a lot of game design ideas and prototypes don't go anywhere. I'm writing these blog posts as I go along, and as there's no guarantee any of the work I'm doing will result in a fun or interesting game, it's totally possible this will turn into a public documentation of a failed project. 

If that happens, though, I think that's just as interesting as process documentation for a successful project! A lot of the writeups you see of alt control games tend to be after-the-fact explanations of successful projects; I think there's value in showing the messy in-the-moment process as well.


## Step 1: Brainstorming

Before I dove head-first into the technical minutia of writing code to talk to my Bluetooth hardware, I wanted to brainstorm ideas and start thinking about what I could actually make.

After some time at the coffee shop with my favorite notebook and pen, I came up with a few major design goals for the project.

#### Make something that works well at in an event setting

While I could theoretically release a commercial game for anyone who owns a Bluetooth-compatible smart trainer, the audience of people who own expensive specialist cycling hardware AND want to play a weird experimental indie game is niche enough that I'd want to do a fair amount of market research before designing anything specifically for that audience. If these experiments prove successful, I'd very much love to do that, but at this exact moment my main goal is artistic expression moreso than money. That means starting out by designing for an installation setting. Specifically:

1. **Relatively short playtimes**. In event settings, you want to be able to cycle (hah!) people through pretty regularly. This will also help prevent the game from being too physically demanding, which is a good thing for a casual party game in a space where players are likely to be drinking.
2. **Spectator enjoyment**. There will be more spectators than players; making something that's fun to watch is important. If I can come up with a way for the audience to participate, so much the better.
3. **A metastructure** that encourages asynchronous interaction between players. This could be as simple as a high-score board, or as complex as longer-term goals that require collaboration. Having a game that exists in a physical space for a few hours or a few days opens up a lot of possibilities for interesting long-term emergent player interaction, and I'm inspired by games like [eCheeze Zone](http://www.seempoint.com/echeese) that are designed around that.

#### Respect the affordances of the hardware

When designing any sort of game with nontraditional controls, it's important to understand why those controls are necessary. A game that uses a physical bicycle needs to justify why it's making the player physically pedal instead of just using a normal controller or keyboard/mouse to control a bicycle avatar.

Specifically, the smart trainer setup I have gives me a few different input/outpt mechanisms:

1. **Pedal cadence and speed**, or how quickly the player is pedaling. One way to use this is to give players a target cadence and ask them to stay within a narrow range (both spin classes and traditional cycling interval training do this!). Another is to directly translate pedal speed into in-game movement; a natural application would be a dynamic where moving as quickly as possible is beneficial, but players have to manage their own physical stamina.
2. **Resistance**. My trainer lets you dynamically adjust how difficult it is to pedal. Thematically, this could represent going up or down a hill, but it doesn't have to.
3. **Handlebar steering**. I'm assuming the game will be running on a phone or tablet attached to the handlebars that also serves as the player's game screen. We should be able to use the motion sensors built into the tablet to detect when the player turns the handlebars.
4. **Ringing the bike's bell**. I need to run tests, but it's likely we can just use the phone's microphone instead of needing to wire up the bell to a microcontroller.
5. **Touch input** on the attached phone/tablet. Not the core of the experience, but worth noting.
6. Other inputs? The phone/tablet will have a microphone we can use to detect speech and a camera pointed at the player's face we can run through facial emotion detection algorithms. We could attach any other arbitrary input/output devices to the handlebars. The list goes on.

Given all of that, I came up with three potential ideas:

### A roguelike dungeon crawler

You're an intrepid adventurer traversing the depths of a dungeon... on your trusted bicycle! 

Much like [Crypt of the Necrodancer](https://store.steampowered.com/app/247080/Crypt_of_the_NecroDancer/), starting with a base of a straight-forward dungeon-crawler offers a lot of room to experiment and make interesting design choices.

<center style="margin: 2em">
<a href="/images/necrodancer.jpg" ><img src="/images/necrodancer.jpg" alt="Crypt of the Necrodancer game screenshot" style='max-height: 400px'></a>
</center>

As an example, the dungeon could be very dark, and your in-game light is powered by your pedalling, so you need to always be moving forward if you want to be able to see. A roguelike with free movement where you're always moving forward in real-time could be interesting.

You can imagine all sorts of other hazards that play off of the available inputs: 

* Puzzles that require you to ring your bell, but ringing your bell attracts enemies
* Traps that require you to hit certain RPM targets in order to escape them
* Combat based on dealing more damage if you're moving more quickly than your opponent
* Narrow bridges that demand you don't accidentally veer off to your death

What's nice about this idea is that it's a relative blank slate. If I come up with a hardware interaction that seems interesting, it'd be easy to come up with a justification for how to fit it into the game.

Playing into the roguelike tradition also makes sense for an event. Games are finite length and permadeath gives a natural stopping point for a player. Uncovering the game's hidden areas, optimal strategies, and interesting interactinos between subsystems can provide for interesting conversation across people at an event trying to figure out the game's secrets.


Also, I could call it "Roguebike" and hate myself for it.

### A game about being a delivery person

<a href="/images/uberdrive.png" style="float: right; margin: 1em;"><img src="/images/uberdrive.png" alt="UberDRIVE game screenshot" style='max-height: 400px'></a>

A few years ago, Uber launched a short-lived iOS game called <a href="https://www.uber.com/blog/uberdrive/">UberDRIVE</a> where you play as an Uber driver. It was a weird *The Last Starfighter*-esque stunt to entice people to become Uber drivers, but there was something oddly compelling about driving around a Google Maps view of San Francisco.

Imagine a game where you play as a food delivery courier. Riding across the city to make as many deliveries as you can in a short bounded game session creates a race-the-clock mechanic that works perfectly for both a cycling game and for an event game.

You can imagine building out the game's level so that different routes have different difficulty levels (adjusting the resistance on the bike). Letting players turn to choose their route both offers players tough choices about which route to take and gives us a natural way to use handlebar steering as input.

There are a lot of potential ways to customize the game for a specific event it's being shown at. Using a maps framework like Google Maps to render the game, and procedurally generating missions based on venue data from a source like Foursquare, the game can be set in whatever city it's being shown in (I'm inspired here by games like [911 Operator](https://store.steampowered.com/app/503560/911_Operator/)). 

I could even theoretically let spectators log on to a website to place their own deliveries, giving the active player a bonus for completing audience-ordered deliveries.

The theming is compelling as well. I'm always excited for a chance to use real-world data as a seed for procedural content generation, and a game about being an on-demand worker has a lot of potential for social and political commentary (see: the upcoming [Neo Cab](http://neocabgame.com/), which I'm very excited for!) 

If I want to make a more narrative-focused experience, the moment when you complete a delivery could involve short choice-based narrative storylets about your interactions with your customers, giving space for world-building.


### A synaesthetic fitness-rhythm game

The first time I went to an in-person spin class, I felt like it was trying to evoke the synaesthetic experience of playing a game like [Rez](https://www.youtube.com/watch?v=x_yrCkUNP8k) or [Thumper](https://www.youtube.com/watch?v=gZDHLOqD_pM). I imagined a hypnotic experience where the loud music, pulsating lights, and the rhythm of your own pedaling all fused together to create a deep flow state.

<center style="margin: 2em">
<a href="/images/rez.jpg" ><img src="/images/rez.jpg" alt="REZ Infinite game screenshot" style='max-height: 400px'></a>
</center>

The small, sweaty studio I visited didn't quite live up to my expectations, but I would love to make something that matches the image in my head. A gameplay mechanic based around pedaling on the beat to a shifting music track feels like a natural combination of both existing rhythm games and spin classes.

You could even do it in VR. The current generation of cheap standalone HMDs (the Oculus Go, Lenovo Mirage Solo, Vive Focus) don't require any awkward wires, are powerful enough to run ports of both Rez and Thumper, and are Android-based so piping data from a BTLE device to a Unity game should be possible.

## So, what next?

It's hard to know which of these ideas will work best without getting our hands dirty. My instinct is that what's most important is simply picking _an_ idea, and the act of playing a working prototype on actual hardware will clarify what works and what doesn't.

I quickly ruled out the third idea. I'm excited by it, but it leans very heavily on nailing a very specific aesthetic experience. The prototyping process to prove that out wouldn't lean into my strengths as a designer and engineer. It also fails to meet most of the design goals I established surrounding suitability as an installation piece. 

I think either of the other two ideas are totally viable. 

Focusing on the roguelike would require less upfront design work, letting me play with the hardware more quickly to see what's interesting. The sort of "bottom-up" design process it suggests, letting me prototype fun individual interactions and mechanics and work up to a more coherent concept from those small atoms of fun, has worked very well for me with past alt control games.

That said, I think the delivery game idea makes more sense. For one, it lets me use tools that I'm faster at prototyping with (web and native iOS non-game development tools, rather than Unity). More importantly, given the choice between something as conventionally "game-y" as a dungeon crawler and a more unique (and non-violent!) concept, I'll choose the latter every time. I love making games that directly simulate and explore mundane every real-world activities, and this fits right into that model.

So, I have an idea! 

**In the next blog post**, we'll shift away from design and talk about low-level tech! I'll be writing Swift code to connect to my smart trainer via BTLE, and start reading in actual live data.


