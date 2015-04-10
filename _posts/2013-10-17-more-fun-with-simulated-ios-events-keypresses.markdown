---
layout: post
title: "More fun with fake iOS events: keypresses"
date: 2013-10-17 11:10
comments: true
categories: [Objective-C, Code]
---

After my [adventures in faking iOS touch events](http://blog.lazerwalker.com/blog/2013/10/16/faking-touch-events-on-ios-for-fun-and-profit/), I assumed I was looking at more of the same slow process of reverse-engineering the right values to pass into a GSEvent object.

A curious thing happened, though. `GSEvent.h` defines a GSKeyInfo object, and there are even functions with helpful-sounding names like `GSEventCreateKeyEvent()`, but actually tapping a letter on the on-screen keyboard doesn't cause your application to receive a GraphicsServices keyboard event. It just receives normal touch events, which get directed to the application's UIKeyboard object. From there, something inside the black box of UIKeyboard causes the actual keypress to happen.

(As an aside, I'd be willing to wager that the key event objects referenced in `GSEvent.h` are generated when you have a hardware keyboard attached to your iOS device.)


After diving into the [UIKeyboard private headers](https://github.com/nst/iOS-Runtime-Headers/blob/master/Frameworks/UIKit.framework/UIKeyboard.h), I found something interesting.

{% highlight objc %}
- (id)_typeCharacter:(id)arg1 withError:(struct CGPoint { float x1; float x2; })arg2 shouldTypeVariants:(BOOL)arg3 baseKeyForVariants:(BOOL)arg4;
{% endhighlight %}

Bingo! If you want to create a synthetic keypress when there is already a keyboard visible on-screen, all you need to do is call a few private methods on it. I opened up a category interface to expose the necessary methods.

{% highlight objc %}
@interface UIKeyboard : UIView

+ (UIKeyboard *)activeKeyboard;
- (id)_typeCharacter:(id)arg1 withError:(CGPoint)arg2 shouldTypeVariants:(BOOL)arg3 baseKeyForVariants:(BOOL)arg4;

@end
{% endhighlight %}

Using those two guys, it's easy to get a pointer to the currently-visible keyboard and tell it to do its thing.

Worth noting: you would expect `_typeCharacter:(...)` to take in a single character. However, you'll notice it accepts an NSString rather than a char or a UniChar. It does in fact expect the string you give it to match up to a single keyboard key. There's probably a good reason for this, but for now we'll just have to write it off as an oddity of the private API.

{% highlight objc %}
NSString *someString;

UIKeyboard *keyboard = [UIKeyboard activeKeyboard];
if (keyboard) {
    for (int i=0; i<someString.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *singleChar = [someString substringWithRange:range];
        [keyboard _typeCharacter:singleChar withError:CGPointZero shouldTypeVariants:NO baseKeyForVariants:NO];
    }
}
{% endhighlight %}

And there you have it, programmatically-created keypress events!

The standard disclaimer applies: if you want to submit your app to Apple for release on the App Store, don't do this. It'll get rejected.

