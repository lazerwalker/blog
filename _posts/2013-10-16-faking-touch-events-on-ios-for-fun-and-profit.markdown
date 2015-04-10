---
layout: post
title: "Faking touch events on iOS for fun and profit"
date: 2013-10-16 17:15
comments: true
categories: [Objective-C, Code]
---

When you tap on your iPhone's screen, capacitive sensors recognize that a circuit has been completed at a certain point on the screen. That gets translated at a low level into, "hey, someone touched the screen at these (x,y) coordinates." That's easy enough to understand.

But if you tap an on-screen button, how does iOS translate from recognizing that it's received a touch event to actually pressing that button? And how can you trick the system into thinking it's received a button tap that didn't actually happen?

## A brief primer on UIEvents and UITouches
If you read Apple's public API documentation, there are a handful of high-level event objects that are handled by your application layer. When a touch event is received, the active UIApplication receives a `sendEvent:` message with a UIEvent object (technically, a private subclass called UITouchesEvent) containing a set of UITouch object.

From there, it delegates down to the `sendEvent:` method on the active UIWindow, which in turn figures out the appropriate UIResponder object to forward the event on to, which for a touch event is probably a UIView. That UIView will then receive a message like `touchesBegan:withEvent:`, `touchesMoved:withEvent:`, `touchesEnded:withEvent`, or `touchesCancelled:withEvent`, depending on the event. If you've been doing iOS development for a while, it's likely you've had to subclass one of those methods.

I'm working on a [project](https://github.com/lazerwalker/capybara-touch) right now where I need to be able to programmatically create and dispatch touch events to a UIWebView. Since a UIWebView is a black box with a fairly limited public interface, there's no fudging it; I need a proper UIEvent object that the UIWebView will accept and respond to.

## UITouch Me
It would be seemingly sensible to figure out how to instantiate your own UITouch and UIEvent objects. If you Google around for faking touch events, that's the route a lot of people take.

Conceptually, though, it's not a great approach. Dealing with private frameworks is a necessary evil; minimizing the surface area of private code you're reaching into is essential since Apple could introduce breaking changes at any time. Faking events at the UITouch and UIEvent level requires touching three different private APIs, which creates three distinct possible points of failure.

A practical example of this: the most widely-read article on faking iOS touch events is a 2008 [Cocoa with Love article](http://www.cocoawithlove.com/2008/10/synthesizing-touch-event-on-iphone.html). Even if you fix the basic syntax errors in the included code (it's not the author's fault; Objective-C has changed a lot in five years), it flat-out doesn't work any more.


## GraphicsServices

Enter GraphicsServices.framework, the private framework responsible for handling events at a system level. When you touch the screen, that gets translated at a low level into a GSEvent object, a C struct containing various information about the event. GSEvents represent all kinds of system events, from hardware button presses to low memory warnings. It turns out that UIEvent objects are little more than light wrappers around GSEvent objects; you can even access a UIEvent object's underlying GSEvent by calling the private `_gsEvent` method on it.

After a GSEvent has been created, it gets dispatched using a function called `GSSendEvent()` that takes in a reference to a GSEvent and the internal port of an application to receive the event (some events get handled by system processes like the Springboard rather than the frontmost application).

If that target is the frontmost application, the GSEvent object somehow gets wrapped in a UIEvent and passed to the application via the `sendEvent:` method described above. (I don't know whether that's the same for events bound for system processes, but that's not particularly relevant for our immediate purposes.)


This suggests an easier route: if we can create a fake GSEvent and use `GSSendEvent()` to route it directly to our application, we can bypass needing to manually create UITouch and UIEvent objects by letting the system do it for us.

It turns out that this is a fairly regular pattern for developers of jailbroken apps, who  often need to do things like simulate pressing the home button or tapping the status bar. Despite the regularity with which jailbroken app developers dive into this framework, though, there is very little documentation of how to actually do it.

## Putting it all together

First, you need to import both GraphicsServices.framework and its header files into your application.

In my personal development environment (OS X 10.8.5, Xcode 5.0 build 5A1412), the framework was located at

	~/Library/Developer/Xcode/iOS\ DeviceSupport/7.0\ \(11A4449d\)/Symbols/System/Library/PrivateFrameworks/GraphicsServices.framework`

I used a copy of the headers I downloaded from a GitHub repo containing an iOS SDK header dump. I used [nst/iOS-Runtime-Headers](https://github.com/nst/iOS-Runtime-Headers), but others exist. Throw the GraphicsServices folder into your project, and `#import "GraphicsServices.h"` where relevant.

After that's all set up, there are three things to do: construct a GSEvent object, get the port of your application, and tell the system to send your GSEvent to your application's port.

### Constructing a GSEvent

If you look at `GSEvent.h`, you can see all of the properties that make up the GSEvent, GSEventRecord, and GSHandInfo structs.

For me, finding the proper values to set was a process of trial and error. The GSEvent.h header is useful, as is manually inspecting real GSEvent objects (with the help of a custom UIWindow subclass with an overwritten `sendEvent:` method). It's possible some of the properties I'm setting below aren't necessary, or might need to be changed for your purposes.

{% highlight objc %}
// Get these two values from elsewhere
CGPoint point;
UITouchPhase phase;

uint8_t touchEvent[sizeof(GSEventRecord) + sizeof(GSHandInfo) + sizeof(GSPathInfo)];
struct GSTouchEvent {
    GSEventRecord record;
    GSHandInfo    handInfo;
} * event = (struct GSTouchEvent*) &touchEvent;
bzero(event, sizeof(event));

event->record.type = kGSEventHand;
event->record.subtype = kGSEventSubTypeUnknown;
event->record.location = point;
event->record.timestamp = GSCurrentEventTimestamp();
event->record.infoSize = sizeof(GSHandInfo) + sizeof(GSPathInfo);

event->handInfo.type = (phase == UITouchPhaseBegan) ? kGSHandInfoTypeTouchDown : kGSHandInfoTypeTouchUp;
event->handInfo.pathInfosCount = 1;

bzero(&event->handInfo.pathInfos[0], sizeof(GSPathInfo));
event->handInfo.pathInfos[0].pathIndex     = 1;
event->handInfo.pathInfos[0].pathIdentity  = 2;
event->handInfo.pathInfos[0].pathProximity = (phase == UITouchPhaseBegan) ? 0x03 : 0x00;
event->handInfo.pathInfos[0].pathLocation  = point;

{% endhighlight %}


One thing to note: the CGPoint you pass into the event's `location` field and the pathInfo's `pathLocation` field are coordinates relative to the entire window, not the UIView that will ultimately receive the event. If you have coordinates relative to a view and a reference to the view itself, you can convert the coordinates using `[view convertPoint:point toView:view.window]`.

### Getting your application's port

This function was cribbed pretty much wholesale from [Stack Overflow](http://stackoverflow.com/questions/16156831/how-to-find-the-purple-port-for-the-front-most-application-in-ios-5-and-above/16157532), although I ripped out a bunch of unrelated code related handling the lock screen.

{% highlight objc %}

#import <dlfcn.h>
#define SBSERVPATH  "/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices"

static mach_port_t getFrontmostAppPort() {
	mach_port_t *port;
	void *lib = dlopen(SBSERVPATH, RTLD_LAZY);
	int (*SBSSpringBoardServerPort)() = dlsym(lib, "SBSSpringBoardServerPort");
	port = (mach_port_t *)SBSSpringBoardServerPort();
	dlclose(lib);

	void *(*SBFrontmostApplicationDisplayIdentifier)(mach_port_t *port, char *result) = dlsym(lib, "SBFrontmostApplicationDisplayIdentifier");

	char appId[256];
	memset(appId, 0, sizeof(appId));
	SBFrontmostApplicationDisplayIdentifier(port, appId);

	return GSCopyPurpleNamedPort(appId);
}
{% endhighlight %}

### Sending the event

We have a GSEvent object, `event`, and a function that will return the frontmost app port. Let's put 'em together.

{% highlight objc %}
mach_port_t port = getFrontmostAppPort();
GSEventRecord* record = (GSEventRecord*)event;
record->timestamp = GSCurrentEventTimestamp();
GSSendEvent(record, port);
{% endhighlight %}

And there you have it!

If you want to simulate a full tap event, you want to construct two events, one where the phase is `UITouchPhaseBegan` and one where it's `UITouchPhaseEnded`. Similarly, a gesture would have you sending `UITouchPhaseMoved` as often as necessary between those two.

If you want to see the final result in production code, check out the [UIFakeTouch](https://github.com/lazerwalker/capybara-touch/blob/master/ios/capybara-touch/Extensions/UIFakeTouch.m) class I ended up writing for use in my project.

## A word of warning
It goes without saying that this isn't a technique that should be used in applications destined for release in the App Store. By all means use it for your Cydia apps or for applications not designed for production release, but if you submit an app to Apple that links against GraphicsServices.framework it will almost certainly be rejected.


## A second word of warning: iOS 7
This approach doesn't work with iOS 7. While it doesn't appear that the header files of GraphicsServices.framework have been modified, Apple has changed the way that it works under the hood such that it silently fails.

You can still use this technique using the iOS 7 SDK and Xcode 5, just make sure you're targetting iOS 6.1 or earlier. When I have the time to dive into it, I hope to write a follow-up post on iOS 7 compatibility. Let me know if you have any success!
