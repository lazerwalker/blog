---
layout: post
title: "A tale of two protocols: UITableViewDelegate, UITableViewDataSource, and heightForRowAtIndexPath"
date: 2013-12-01 23:46
comments: true
categories: [Objective-C, Code]
---

UITableView is one of the undisputed workhorses of iOS development. It's present in almost every iOS app, a shining paragon of API design ready to do a lot of the heavy lifting in more than a few common situations. But as wonderful as it is, its unique position as one of the few APIs in Apple's toolbox with two protocols to implement (UITableViewDelegate and UITableViewDataSource) can occasionally provide some interesting intellectual fodder.

At first glance, the distinction between the data source and the delegate is obvious and welcome: the data source handles providing it the actual data, whereas the delegate is responsible for giving it some useful information about how to visually lay itself out and how to handle user interaction. We're all smart people here; we understand that the separation of presentation and content is a Good Thing™, and we're used to Apple designing its APIs so as to encourage this sort of good behavior.

But there's an uncomfortable gray zone, a poor lone method that seems to have gotten lost in the seams: `tableView:heightForRowAtIndexPath:`. In many circumstances, there's no getting around that the height of a cell is directly dependant on the data being presented inside of it. Need to make a cell smaller if a certain piece of data is missing and thus shouldn't be shown? Or perhaps make the cell long enough to fit a varying-length block of text? You need to consult your model data to know how to make those calculations, which seems to go against the pattern Apple is trying to encourage.

Of course, in practice, it turns out that most iOS developers tend to make a UITableView's delegate and its data source the exact same object. So this is really more of a debate over semantics than anything else. But that doesn't clear up the question of why `tableView:heightForRowAtIndexPath:` is the only method in UITableViewDelegate that regularly and consistently requires some sort of knowledge of your underlying data.

Here's my theory. We're all intimately familiar with `tableView:cellForRowAtIndexPath:`, the UITableViewDataSource method responsible for returning a valid UITableViewCell for a given index path. Most developers I've talked to tend to do most of their cell configuration and layout in that method, or at least what configuration and layout don't happen inside a custom cell subclass. But what if that's not where it's supposed to happen?

UITableViewDelegate has a lesser-known method called `tableView:willDisplayCell:forRowAtIndexPath:`. After `tableView:cellForRowAtIndexPath:` is called, the system does a little bit of layout configuration itself, then calls this method before doing the actual on-screen rendering. What if this is where Apple intends for our configuration to go?

I've been happily doing just that since a coworker introduced me to that method seven or eight months ago. Just as `tableView:heightForRowAtIndexPath:` is responsible for merging knowledge of domain objects with layout implementation details to come up with a valid height number, I tend to make `tableView:willDisplayCell:forRowAtIndexPath:` responsible for doing all the fiddly bits of view configuration that, for whatever reason, don't quite belong in a UITableViewCell subclass or subclasses. `tableView:cellForRowAtIndexPath:` exists purely to allocate and initialize a cell of the correct UITableViewCell subclass, and then pass it along to `tableView:willDisplayCell:forRowAtIndexPath:` to do all the heavy lifting.

This doesn't prohibit me from creating presenter objects or implementing any of the other useful design patterns that we as software developers have come up with over the years, but it does create a nice separation of concerns: one method exists purely to instantiate objects, the other purely to configure them.

Maybe this is all an academic exercise. Maybe there's some glaringly obvious bit of logic I've been completely blind to (if that's the case, you should definitely [yell at me on Twitter](https://twitter.com/lazerwalker)). But in practice, I've found my table view code far cleaner and easier to reason about since I've started separately allocating my table view cells in `tableView:cellForRowAtIndexPath:` and configuring them in `tableView:willDisplayCell:forRowAtIndexPath:`. And it makes `tableView:heightForRowAtIndexPath:`'s position as part of UITableViewDelegate instead of UITableViewDataSource a much more sensible API design decision.