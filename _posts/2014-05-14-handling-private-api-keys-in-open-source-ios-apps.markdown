---
layout: post
title: "Handling private API keys in open-source iOS apps"
date: 2014-05-14 13:23
comments: true
categories: moves, objective-c, open-source
---

While working on Foursquare API integration for my [iOS Moves clone](http://blog.lazerwalker.com/blog/2014/05/13/building-a-moves-clone-day-1/), I ran into an interesting conundrum. Using the Foursquare API requires a client ID and client secret. Obviously, these values shouldn't live in the git repo. This is an  easily-solved problem in the world of server-side software (just use `ENV` variables), but that doesn't really work as well as one would like with Xcode's build toolchain. While these values could live as build flags in the target settings or in the project's plist file to keep them out of the actual codebase, integrating them as part of the versioned project files doesn't avoid the actual problem here.

I looked around, but couldn't really find a decent solution recommended by anyone else. It makes sense; while there are lots of open-source iOS libraries that require plugging in private API keys, they're all third-party libraries designed to be integrated within a larger app. They can leave the issue of key storage up to you.

The solution I ended up with was having a separate configuration plist that the app read from as necessary. A `configuration.plist.example` file is versioned in git, whereas the actual `configuration.plist` file read by the app is included in the project's `.gitignore`. Here's what the example plist currently looks like, for reference:

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>FoursquareAPI</key>
	<dict>
		<key>ClientID</key>
		<string>YOUR CLIENT ID HERE</string>
		<key>ClientSecret</key>
		<string>YOUR CLIENT SECRET HERE</string>
	</dict>
</dict>
</plist>
{% endhighlight %}

And here's what the code to fetch the client ID and secret out of the plist looks like:

{% highlight objc %}
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Configuration" ofType:@"plist"];
    NSDictionary *configuration = [[NSDictionary alloc] initWithContentsOfFile:plistPath];

    NSString *clientId = configuration[@"FoursquareAPI"][@"ClientID"];
    NSString *clientSecret = configuration[@"FoursquareAPI"][@"ClientSecret"];
{% endhighlight %}

*(A more production-ready solution will naturally have sanity checks to make sure both the file and those dictionary keys exist, plus sensible fallbacks if appropriate and/or human-readable errors or exceptions. In this specific case, I eventually plan to abstract this out into a separate configuration object.)*

At a high-level, this solution isn't ideal — a newcomer cloning the git repo won't even be able to build the project without renaming the example plist or making their own — but it seems to strike a decent balance between convenience and privacy.

If you've encountered this problem before and come up with a different solution, definitely get in touch! I'd love to hear about it.

*(It's worth mentioning that of course you can rarely/never trust client application keys to be truly secret; it's often trivially easy for a bad actor to extract plaintext strings like API keys from your app. Unless you're going to great lengths to encrypt/obfuscate your keys in your production binary, there's a level at which this discussion is purely academic.)*
