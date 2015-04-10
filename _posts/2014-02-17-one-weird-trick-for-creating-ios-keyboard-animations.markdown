---
layout: post
title: "One Weird Trick for creating iOS keyboard animations"
date: 2014-02-16 19:19
comments: true
categories:
---

The past week, I found myself solving the same problem multiple times: creating animations that happen contemporaneously with the iOS keyboard animating up. It's not difficult, but as with many bits of the iOS SDKs there are a lot of fiddly bits to get in order.

If you want to, say, shrink a UIScrollView or adjust its content offset, you have to time the animation of the resize to match that of the keyboard animation or else suffer a jarring jump effect.

Even if you manually figured out what the animation duration and timing curve should be, Apple has been known to change it without warning or documentation even between minor point releases.

The solution I landed on involves grabbing the animation duration and curve out of the NSNotification object itself (an idea taken, admittedly, from StackOverflow). From there, I wrapped it in a convenient helper method reminiscient of UIView's other animation methods. Nothing here is rocket science, but perhaps this will be useful to you.


**UIView+KeyboardAnimation.h**
```obj-c
@interface UIView (KeyboardAnimation)

+ (void)animateWithKeyboardNotification:(NSNotification *)notification
                             animations:(void(^)(CGRect keyboardFrame))animations;

@end
```

**UIView+KeyboardAnimation.m**
```obj-c
+ (void)animateWithKeyboardNotification:(NSNotification *)notification
                             animations:(void(^)(CGRect keyboardFrame))animations {
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    if (UIInterfaceOrientationIsLandscape([[UIDevice currentDevice] orientation])) {
        CGFloat height = CGRectGetHeight(keyboardFrame);
        keyboardFrame.size.height = CGRectGetWidth(keyboardFrame);
        keyboardFrame.size.width = height;
    }

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
    [UIView setAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationBeginsFromCurrentState:YES];

    animations(keyboardFrame);

    [UIView commitAnimations];
}
```

**Update**: This has now been published as its own [CocoaPod](https://github.com/lazerwalker/MWKeyboardAnimation). If you're interested in using something like this in your own projects, check it out!