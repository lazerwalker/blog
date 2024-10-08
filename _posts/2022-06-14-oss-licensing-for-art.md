---
layout: post
title: "Adding a license to your open source art project"
date: 2022-06-14 14:00
comments: true
---

As someone who spends a lot of time straddling the world of “professional” corporate open source software and digital artists making weird new tech, I encounter something regularly that makes me sad. 

Someone will release a cool art project they’ve made, or a creative tool, or some other awesome bit of creativity! They're excited to put it out in the open so that others can use what they've made and learn from their process! That’s great! However, they didn’t include an open source license. That’s not so great!

## Why do you need a license?

By default, if you put source code (or art assets) up on the Internet, that does not mean that anyone is allowed to use it. You still own the copyright to that code, and anyone using your code is committing copyright infringement. In order to for someone to legally be able to use your IP, you need to explicitly grant them the right to do so. In practice, if you publish your project's source code and assets online without a license, you’re probably unlikely to sue someone who uses those assets, but on paper that’s illegal infringement.

Regardless of whether your goal is restricting the use of your source code to specific uses or just telling people “hey, do whatever you want with this”, being straight-forward about your intentions is valuable. Telling someone explicitly what you do or don’t want them to do with what you’ve made, instead of needing them to assume what rights they don’t have, is going to lead to people feeling more comfortable looking at and potentially using your work!

Additionally, if your project accepts contributions from the community, if you get any contributions that don’t include a license, you technically don’t have the right to use those changes! A model of “this is the way my code is licensed, and anyone contributing is agreeing to the same terms” is a valuable way to protect yourself.

The solution to all of these ambiguities is to add a license: a bit of legalese to this git repo that explains the legal IP rights that anyone visiting this repo has to the code and assets stored in it.

## What license should I choose?

There's sadly no one "correct" answer for what license you should use. Even though this is relatively cut-and-dry for e.g. open source infrastructure projects built by tech startups, it gets fuzzier for art projects like this, and there is a lot of wiggle room depending on your goals.

I've got a few different recommendations below, but first it's worth separating out that we're talking about two different things here. On the one hand, a license explicitly grants legal IP use rights to anyone who comes across this repo, and makes it legal for them to do certain things with your IP. On the other hand, you are presumably trying to communicate intent about how you as a creator want people to be able to use your work. 

In an ideal world, these two things are one and the same! In practice, OSS licenses are rather blunt tools, and it's useful to separate out "what am I communicating about my intent?" from "what rights am I legally granting?".

That said, here are three(ish) good options to consider, with the caveat that I am not a lawyer and this is not legal advice.

## An OSS license and a Creative Commons license
A tricky thing is that "open source licenses" are written with code in mind, and it's a bit ambiguous how they apply to non-code things like art assets. A good rule of thumb is that if a piece of IP can be versioned the same way one would use source code, an open source license might be a good fit for it -- this means that things like hardware design files from software like KiCad can probably be safely protected under an OSS license, but 2D images or music might benefit from other licensing options.

Outside of a few special cases (e.g. the [SIL Open Font License](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=ofl) for fonts), the gold standard for licensing binary assets is [Creative Commons](https://creativecommons.org/), who maintain a large number of licenses allowing for different types of use. 

The inverse applies as well: because licenses like Creative Commons focused on artistic works don't care about the difference between binary distribution and source distribution, this makes them relatively unsuitable to use for covering code (even Creative Commons themselves [don't recommend it](https://creativecommons.org/faq/#can-i-apply-a-creative-commons-license-to-software)).

A common technique is to use multiple licenses within the same open source repository: all code is under one OSS license, and all non-code assets are under a Creative Commons license. This is a great option to remove ambiguity for projects that include both code and not-code.

### Choosing a Code License: MIT License vs GPL 
There are a large number of open source licenses you can use to license your source code. I want to focus on two today, the MIT License and the GPL License. Both are _extremely_ popular, arguably moreso than any other open source licenses (they're the two licenses GitHub points people towards with their [Chose a License](https://choosealicense.com) site). There are many popular licenses similar to the MIT license, but comparing MIT and GPL is useful since they're examples of two very different philosophies.

**The MIT License** basically says "you can do whatever the heck you want with my code, as long as you give me credit". 

**The GPL** basically says "you can do whatever you want with my code, as long as any changes you make to my open source code are themselves made open source and licensed under the GPL".

The MIT license grants "freedom" in the sense that anyone can use your code however they want, up to even using it as the basis for a proprietary closed-source commercial product. The GPL grants "freedom" in the sense that, even though it restricts what people can do with your code, it does so in a way that leads to more open source software and thus net more "freedom" for end users. This concept of freedom the GPL represents is often referred to as "copyleft" (as opposed to "copyright")

Most open source software maintained by large tech companies is MIT or a similarly-philosophically-aligned license (Apache and BSD are two others you see a lot), because the economic model behind that sort of OSS is generally "a bunch of tech companies all contribute to this thing in order to benefit from it in their closed-source commercial products". These corporations would not consider being forced to open source all of their commercial products that happen to depend on GPL'd libraries to be a reasonable outcome, so this sort of corporate OSS tends to default to more "liberal" licenses that allow closed-source use.

There's no clear correct answer. For-profit corporations find financial benefit in making licenses like MIT more common, but that doesn't mean that's the right choice for you. 

It's also awkward and worth noting that the GPL's author and main evangelist for decades is an alleged sex pest who (among many other things) resigned from his position at MIT after public comments defending Jeffrey Epstein. Regardless of how you feel about the ideas and ideals underlying the GPL and the Free Software Foundation, there's a lot of cultural and political baggage there. I don't think that's a reason to avoid the GPL, but it's worth being aware of.

It's also worth noting here that there are weird politics around the term "open source". In order for a license to be considered "open source" by the Open Source Initiative, there are a number of criteria the license must meet. One of those criteria is that it must allow equal use to everyone. You won't see an "open source" license that restricts commercial use, because that by definition makes it not capital-O Open Source. I personally think this is bad!

### Various Creative Commons Licenses
As mentioned, Creative Commons is a non-profit that maintains a set of  intended to be used for creative works, rather than source code.

There are a half-dozen different Creative Commons licenses you can choose. They span more or less the same ideological spectrum of MIT vs GPL, but with a bit more fine-grained choice around what restrictions are placed on what people can do with your work. 

The [Creative Commons License Chooser](https://creativecommons.org/choose/) is a good way to look at your options and how these differ. All CC licenses require attribution (except for CC0, but I'll talk about that later). You have a choice of whether or not you allow commercial use of your work, as well as a choice of whether adaptations of your work are allowed to be shared, not allowed to be shared, or require any derivative works to also be licensed under the same terms as your work (similar to the GPL).

While restricting commercial use in derivative works may sound extremely appealing, Creative Commons themselves are philosophically opposed to it, in favor instead of what they call "[free cultural works](https://creativecommons.org/share-your-work/public-domain/freeworks)". Their viewpoint is basically "eh, we don't want to allow this, but it's better that works be CC Non-Commercial than to not have any CC license". In particular, a concern I would have is how loosely "commercial use" is defined, and making sure that you’re actually disallowing the use cases you think you are.

To me, in a lot of situations where I'd be tempted to add a non-commercial clause, I'd instead consider adding a share alike clause. If what you want is for people to be able to freely remix your work, letting people release commercial products based on it but requiring them to also license those works under Creative Commons feels like a good compromise -- it's philosophically similar to the GPL, but without a lot of the legal or cultural baggage. 


### Do you lean on the side of leniency or strictness?
Deciding whether to use a MIT-like license or a copyleft license (or whether or not your CC license should have a share alike clause) is a tough decision.

In my own work, I personally usually explicitly want to encourage others to make their improvements to my work public, but often find that _requiring_ that unintentionally limits some uses you'd like to enable. As a common example, if you would like people to be able to read your code as a reference, the GPL will allow that, but it technically forbids someone from copying a three-line snippet of code and using that in their own project, without making their entire project open source under the terms of the GPL as well. That may be what you personally want, but in many cases I personally find that to be a bit excessive. 

This is perhaps less likely to happen with a CC share alike license (just because it's less likely someone would pull out and use a tiny fraction of an art asset), but your license virality being too overbearing is still a concern in either case.

Of course, people may still informally use your code in that way anyway, and you may be okay with that (read: not pursue legal action for violation of the terms of the GPL or CC). But choosing a more stringent legal position than you intend to perhaps enforce is a conscious choice you're making in that situation.


### Intent vs Enforcement
It's worth emphasizing again the distinction between legal IP restrictions and communicating your intent. 

I personally lean towards being more lenient in what I allow legally (read: default to using an MIT-style license and a CC license without non-commercial or share alike clauses), and informally expressing in the project documentation what I do or don't want people to do. 

I find explicitly writing "hey, I know you're allowed to do whatever you want with this, but PLEASE don't do X, Y, or Z" is a nice middle-ground of something that isn’t strictly legally enforceable, but communicates to reasonable human beings what I want.

It's also possible that your personal ideological leanings would rather err on the side of unintentionally restricting valid use cases rather than unintentionally enabling use cases you don't want to allow. That's okay too!

### So, uh, what does this all mean?
If I was choosing a license for this repo, and wanted to go the "OSS + CC" route, I'd probably pick MIT, either CC BY or CC BY-SA ("only attribution required" or "attribution and share alike"), and put a paragraph in the README explaining my intent. But any of the other things mentioned here are reasonable options! 

## 2. [The Anti-Capitalist Software License](https://anticapitalist.software/)
This is a unique license in that it adds restrictions on who can use your software. You can do whatever you want with the code, as long as you're an individual, a non-profit, an education institution, or a worker-owned co-op, with a carve-out banning military and law enforcement use.

I'm inclined to view this license through the lens of performance art. While this license probably most directly aligns with how I personally would want a lot of my projects to be used, I've read a number of arguments claiming it almost certainly would not hold up to litigation, and would basically equate to including no license at all (with the repeated caveat that I am not a lawyer, and I additionally suspect many/most of the people posing those arguments are also not lawyers). It's possible this is unjustified fear, uncertainty and doubt; the current tech industry culture extremely stigmatizes any software licenses like this that do not conform to the "proper" definition of "open source".

Along those lines, this WILL incidentally act as a deterrent to many larger tech companies using your work, as management will look at a non-standard license like this and say "the time and effort saved by using this code is worth less than the billable hours for the legal team to vet this license". This is possibly a positive for you.

This license is on the extreme end of tradeoffs: it is an incredibly strong socio-political statement about how you wish your code to be used, but realistically is likely to leave you in the same legal IP situation as if you had not included a license at all. Using this license does have the positive benefit of normalizing licenses like this, which could eventually lead to future iterations of the idea that are more proven to be legally-enforceable.

## 3. [Creative Commons 0](https://creativecommons.org/share-your-work/public-domain/cc0/)
A final option is to place your work in the public domain: you relinquish all rights to them, and anybody can use your IP for whatever purposes they want. This is "chaos mode" -- it's definitely the simplest of all these options, and the most easily-understood by people who don't want to have to become armchair IP lawyers. But it's also the least restrictive, for better and for worse. It's specifically worth calling out that people are not required to provide credit or attribution.

If your intent is to put your project in the “public domain”, you should still specifically apply the CC0 license. Many countries do not have a legal mechanism (or only have limited ways) by which a living IP holder can dedicate their work to the public domain. CC0 is explicitly written to work around this, and allows authors to explicitly waive all possible copyright protection and IP rights they have, to the extent possible in their jurisdiction.

# Okay, so how do I actually add a license to my project?
So you've fretted and fussed and finally picked a license or set of licenses that you think are right for your project. What do you do now?

If you just have a single license, this is simple. 

**For a code license**: in your project's repository (I'm assuming you're distributing this project via a git repo, but this could also just be in the folder root if you're e.g. distributing a zip file), include a file called README (or README.md, or similar) containing a copy of your license. 

A bonus improvement is to include the license as a header comment in every single code file. This makes it somewhat less likely that your code will get (unintentionally or intentionally) taken out-of-context and have the licensing info removed from it. This is best practices for larger corporate OSS, but if you don't have good technical infrastructure to do that automatically on your small art project I wouldn't worry too much about it.

**For a creative commons license**: In whatever public documentation your project has (a README, a marketing website, etc), note the CC license prominently. The Creative Commons has great image buttons you can use.

**If you have a mixed license** (like the aforementioned combo of an OSS license and a Creative Commons license) it gets slightly hairier. Combining those two approaches — a LICENSE file and noting the CC license — is broadly correct, although you want to be explicit about which files get which license applied.

This is simpler if your assets are divided up such that you can cleanly say "this specific set of folders are CC licensed, and the rest are using this other code license". There really isn’t a legal standard here for “you MUST indicate things this way or nothing matters”, your goal is primarily making your licensing intent clear and unambiguous.

## ...and that's it?
If you have clear documentation in your repository about how which files are licensed which ways, that's all there is to it! Your project now has a license, and people can feel more comfortable using your work safely, knowing that they're respecting your wishes and intentions!

This of course isn't a silver bullet. If someone willingly infringes on you, your options are still either to take them to court (potentially expensive and time-consuming!) or just let it be. But having an explicit license minimizes the chance you'll get into that sad situation, and also potentially makes it easier even if you do get into that sad degenerate state.

