---
layout: post
title: "The Tension of Alt Control Games"
date: 2015-05-04 14:05
comments: true
categories:
---

There's a tension inherent in games that use custom alternative controllers.

"Alt control" games are some of my favorite games to design. They let us create exciting new experiences that are are a refreshing change from the status quo. They enable interactions that can be much more welcoming to players not used to "traditional" games and all of the cultural baggage implicit in the affordances of the medium (have you ever seen someone who's never played a first-person 3D game try to use a dual-stick control scheme?).

To make all this happen, though, these sorts of games typically have installation requirements that mean they only get shown in festivals, galleries, and other games events. This is a dangerous proposition: despite being the sorts of things that have the potential to draw in new audiences and expand the definition and reach of "games", alt control games typically only exist in spaces already populated by game designers and people heavily invested in games as a hobby and passion[^1].

Given all that, the choice to make a game with a custom controller is not one to be taken lightly. Do these novel interactions add enough to the experience of our games to justify the drawbacks of the form? How do we ensure that custom controls aren't just a gimmick, but in fact enable entire classes of play experiences that simply aren't possible with traditional digital or physical games?

### What Hath God Wrought?
My project <a href="http://lazerwalker.com/telegraph.html">"What Hath God Wrought?"</a> was featured as part of the 2015 alt.ctrl.GDC exhibit.

<em>What Hath God Wrought?</em> puts you in the shoes of a telegraph operator in the 19th century, sending and receiving morse code using actual 19th century telegraph hardware. At a high level, the game is about mastery, and the moments of mental shifts in abstraction that happen as you start to learn a new skill. I can't teach you morse code in five minutes, but I *can* get you to a point where you're listening for overall letter shapes instead of individual dots and dashes, an essential stage in attaining fluency.

Overall, I consider the piece a great success. There are a few bugs I'd fix and a few design tweaks I'd make before showing it again, sure, but at a high level it accomplished what I wanted it to.

That said, elements of its design are objectively sub-optimal. Players almost universally had a difficult time learning to differentiate between dots and dashes, both on the input and output side. There are minor tweaks I could make to improve this slightly, but at a high level I'm convinced that the design choice of using proper morse code, with both dots and dashes, is fundamentally at odds with approachability and having an enjoyable learning curve for players who aren't already familiar with the operation of 19th century telegraph equipment (so, everyone).

The most reasonable and obvious way to solve this is to abstract away the problem entirely. One of the most interesting parts of morse code isn't the literal encoding of letters into specific patterns of dots and dashes, it's the use of such low-fidelity binary communication between two people. That doesn't require using literal morse code at all; it's easy to imagine designing a game that instead moves towards using some hand-designed code that's easier for new players to grasp.

However, as an installation piece, so much of what makes the piece successful is the sense of authenticity: input and output that happens via real vintage 19th century electronics, on-screen visuals taken from real 19th century woodcut illustrations, and actual morse code. I have no doubt that I could make an objectively better game by replacing morse code with something more approachable, but in doing so I'd lose why the hardware is necessary. If you're not learning real morse code, the real telegraph hardware is a curiosity rather than a core part of the experience. If the hardware isn't absolutely essential, I can't justify only showing the game at events I've dragged the physical hardware to, rather than simply releasing it on some sort of downloadable platform that's way more accessible. 

Making the game better, at least for a systems design-centric definition of "better", necessitates the dismantling of the very elements that make the game a successful installation piece. 

This just underlies the tension with alt control games. I'd love it if my installation works were more accessible to a wider audience, but in the meanwhile I'll have to content myself with making sure that their design justifies their limited reach. Making alt control and installation games is absolutely a worthwhile goal, but one that require striking a very delicate balance.

[^1]: To be fair, there _are_ some great events and spaces that emphasize exposure to new audiences. Sadly, they're the exception rather than the norm. Even if not, the current state of alt control games often involves designers exhibiting their games in person. Travelling all over the world to show your game over and over again isn't particularly sustainable, financially or emotionally.



