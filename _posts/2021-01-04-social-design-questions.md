---
layout: post
title: "An (Incomplete) List of Questions To Ask When Designing a Synchronous Online Social Space"
date: 2021-01-04 12:00
comments: true
---

We're in an exciting period of change where we're still figuring out what online events should be. 

Most would agree that, whether you're talking about a birthday party or a professional conference, a large grid of faces in a group video chat likely isn't the ideal setup to foster meaningful online interaction. But we don't really know yet what *is* the ideal setup!

A lot of people are experimenting with new technical platforms to better support spontaneous interactions and small group conversations in online settings ([myself included!](https://blog.lazerwalker.com/2020/10/22/virtual-events-and-game-design.html)), but it's still the wild west. 

Here's a list of questions to ask yourself as you're trying to design a more thoughtful space for online communication.  Many of these are unsubtle leading questions with a 'correct' answer, but others are more open-ended and more meant to encourage reflection.

This list emerged out of my work on the [text-based social space](https://blog.lazerwalker.com/2020/10/22/virtual-events-and-game-design.html) that powered the Roguelike Celebration conference as well as some future events. My goal is to make sure that you're thinking about the right design elements and principles to create a well-considered environment for your event attendees.

To be clear, I'm talking about spaces meant for synchronous real-time communication, and generally (but not exclusively!) about temporary spaces for time-limited events rather than longer-persisting spaces. Think more meetups, parties, and conferences, than coworking spaces, persistent virtual worlds, or traditional social media.

Although a lot of the conversation is currently focused on cartoony 2D environments that include spatial video chat ([Gather Town](https://gather.town) is currently the highest-profile, but I could easily name a dozen competitors), I'm trying to ask questions that are applicable regardless of whether you're a solo event host throwing a party on Zoom for your friends or are a VC-funded startup building a VR platform for 3D virtual worlds.

# Input Methods

* How do you mitigate or minimize exhaustion from the performative nature of extended group video chat (aka "Zoom fatigue")?
* How do you accommodate people who are more comfortable communicating over text or audio chat instead of video?
* If you allow multiple input modalities (text vs audio vs video, VR head and hand tracking vs mouse and keyboard or game controller, etc), how do you ensure that people with lower-fidelity communication methods don't feel like "lesser" attendees than those with a wider range of expression?
* Are your software and communication methods fully accessible? Can people with vision impairment or low vision, people who are deaf or hard-of-hearing, and people with motor impairments all use your tool to communicate with each other?
* What languages does your tool support? Can non-English speakers understand or read your UI? Do your user-editable text inputs (usernames, text chat, etc) support non-Roman alphabets and right-to-left languages?
* If you provide a multitude of input methods, is it clear to attendees what their options are and what the tradeoffs are? This is especially true if you offer options that may be mutually exclusive in practice, such as turning on your webcam vs wearing a VR headset


# Demographics

* What is the average session time for an attendee to your space? A few hours for a meetup or party, a few days for a conference, a persistent long-term coworking space, etc...
* What is the average number of attendees to an event in your space? 10 people, 100 people, and 1000 people have very different needs.
* Do attendees to events in your space typically already know each other, are they all strangers, or somewhere in between?
* If the answer to any of the previous questions is "it depends", what tools are you providing event hosts to make sure their event space is well-tailored to the needs of their specific event?
* If there are specific types of events your space is better suited for, how do you communicate this to event hosts?
* Do the hardware requirements and level of technical involvement required to access your space match the capabilities of an average attendee to your events?

# Fostering Social Interaction
* In what ways does your space provide activities or interactions that can serve as conversational hooks to encourage discussion?
* What level of attention is required to do these activities? Do you offer activities with a range of involvement levels to allow attendees to self-select for how much room for freeform conversation they want versus focusing primarily on a structured activity?
* Separate from level of involvement needed, do your activities provide varying levels of structure and rules, to accommodate people with different levels of creativity and willingness to jump in and try something new? Some people are excited to improvise and play make-believe with little to no prompting; others need more encouragement and structure to make it feel socially acceptable to engage in playful activities.
* Do different types of activities or interactions appeal to different types of attendee personalities? The [Bartle taxonomy of player types](https://en.wikipedia.org/wiki/Bartle_taxonomy_of_player_types) may be a helpful, if incomplete, lens
* How "mandatory" are all of these activities?
* To what extent are these activities or interactions explicit and broadcasted versus being secrets hidden throughout your space? How do you balance encouraging as much involvement as possible with creating a sense of exploration and mystery?
* To the extent that your space has secrets or elements that are less obvious, how does knowledge-sharing about that tie into your other social scaffolding and conversational hooks?
* If your event is centered around a singular activity (e.g. a talk or series of talks), how do you balance between pushing people to attend that activity versus allowing or encouraging people who would prefer to keep participating in the "hallway track" instead?
* If your space is meant to host larger gatherings, how do you foster and encourage smaller group conversations?
* Once attendees are having smaller conversations, how do they find new people to talk to or move to a different conversation?
* If I don't know anyone at an event, how do I find people to talk to with similar interests as me or who want to talk about the same things as me? Is there a way for me to signal my interests, or a place I can go to indicate what I'm looking for?
* If there is technical or design friction involved in moving to a new conversation (rather than social friction), is this an intentional choice designed to create specific conversational dynamics, or is this something you should aim to optimize out?
* How do you balance actively encouraging fluidity of conversations versus letting people deeply engrossed in conversation stay there?
* By default, online spaces won't have the equivalent of "I need to go to the bathroom" or "let me refill my cheese plate". If somebody wants to get out of a focused conversation, do you provide socially-acceptable excuses to leave? 
* How does your social scaffolding scale as users become familiar with your platform? To what extent is it focused on the novelty of the space itself (e.g. is most discussion focused on how cool and original the space is, how much it feels like you're talking in-person, etc?) or does it still provide useful conversational hooks for expert users?
* How can a person or conversation group broadcast things such as "we'd love to talk to new people!" or "go away, we're having a private conversation" to others? In physical spaces, these would typically be communicated via subconscious body language cues that can be difficult to directly recreate digitally.

# Aesthetics and World-Building
* Does the aesthetic theming of your space match the tone of the event? A house party is not a professional conference is not a friendly coworking space
* If you are a platform or a space where the answer to the previous question is "it depends", what creation tools do you offer event hosts (or attendees!) to customize the feeling of a space?
* If you provide creation tools, how do you educate event hosts not just how to use them but how to build good things with them? Are you providing event hosts who aren't architects or videogame level designers the scaffolding they need to create spaces that succeed at an intentional design goal?
* If your space is graphical, what sort of art assets or visual design creation tools do you provide? Can event hosts bring their own assets if they want to? Are they required to bring their own assets?
* If event hosts or attendees are encouraged to provide their own art assets, what are the barriers to entry for creation? Creating 3D models is more work than 2D sprites is more work than writing prose text.
* To what extent can attendees modify or shape the space? Do they have access to the same creation tools as event hosts? If not, are there alternative ways for them to express themselves in the space in a persistent or semi-persistent way?
* How much control do attendees have over their own presentation? This could mean anything from usernames and user profiles to 2D or 3D avatars to something else entirely. How do these forms of self-expression themselves provide hooks for people to start conversations about?
* Do your various forms of attendee self-expression provide space for in-jokes and spontaneous culture to emerge over the course of the event? How do your creative tools actively encourage this?

# Trust and Safety
* Do you provide event hosts the tools to effectively moderate their events and enforce a code of conduct? (e.g. the ability to ban attendees and remove individual messages, tools for users to report CoC violations and issues, perhaps some sort of secure auditable log to review in the case of CoC reports)
* Do individual attendees have the trust and safety tools they need to minimize the damage of abuse or harassment without escalating to the event hosts? (e.g. robust muting and blocking tools)
* Do you have sufficient live human moderators at your event to make attendees feel safe? Depending on your space, it may not be feasible (or even desirable!) to have an organizer present and listening in every possible space where people might congregate, but do attendees feel comfortable with the level of moderation when they need to e.g. report a CoC violation?
* Many event organizers in VR social spaces feel the need to explicitly explain to new attendees that, as in the real world, standing too close to someone else in VR is viewed as an invasion of personal space. Does your space have cultural norms where unintentional violations may cause discomfort or harm, and if so how do you communicate and educate about them?
* When designing various features and interactions between users, have you actively considered how those features might be vectors for abuse and harassment and designed defensively against that?
* How do you balance a desire to allow pseudonymity with a desire to keep bad actors accountable for their actions? How does your user registration policy and user profile design reflect this?
* If you as a larger platform place restrictions on allowed content, are your rules and enforcement policies explicit? Is it clear what will happen when the policies of a specific event conflict with the platform as a whole?
* How do you control user access to specific events? Where do you strike the balance between making it as simple as possible to join an event versus preventing bad actors and trolls from entering events they were not invited to?

# Technical limitations
* What hardware is needed to access your space? Does it run on mobile devices? How about an underpowered 5-year-old computer?
* If someone attempts to use your space with underpowered or unsupported hardware, are they warned about potential issues before joining? Are they prevented from joining entirely?
* Does accessing your space require a downloadable executable, or can it run in a web browser?
* If your space is focused on a certain technology (e.g. videochat, or VR head + hand tracking), does it meaningfully work without appropriate hardware? 
* Do event hosts feel like they need to spend a meaningful portion of their event providing instruction and technical assistance to attendees?

This is naturally an incomplete list of concerns, but hopefully is helpful as you work on your own novel online social spaces and events!

If you're working on something cool, I'd love to hear about it! Feel free to [say hello](https://twitter.com/lazerwalker), I'm always excited to check out exciting new experiments in this space.