---
layout: post
title: "The Objective-C runtime: objc_msgSend_stret "
date: 2013-10-12 11:10
comments: true
categories: Objective-C, Code
---

Ah, the Objective-C runtime. One of the most overlooked features of the language, and yet perhaps the most important part. It's the glue that enables the dynamism and expressibility of a Smalltalk-like messaging model on top of C; it's what makes Objective-C so great.

In practical terms, it's rare for an iOS or OS X developer to need to dive down to the runtime level — in most cases, I'd say it's actually a code smell — but it's still worth having a basic understanding of how things work under the hood. I'm not going to give you a general overview of the runtime, but rather explore a specific edge case I encountered recently while working on a testing framework.

The meat-and-potatoes of the Objective-C runtime is `objc_msgSend`, the C function responsible for sending a message to an object. When you write the following line of Objective-C code:

``` objective-c
[tableView cellForRowAtIndexPath:indexPath];
```

The compiler actually translates it down into the following C function call:

```
objc_msgSend(tableView, @selector(cellForRowAtIndexPath:), indexPath);
```

There are a million interesting things to say about `objc_msgSend` and how it works, but today I want to focus on an interesting edge case. The return type of `objc_msgSend` is `id`: what happens if you need to evaluate a method that returns a primitive or C struct rather than something expressible as an object pointer?

Executing the following contrived example returns a compiler error because of the type mismatch:

```
UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
CGRect rect = objc_msgSend(view, @selector(frame));
```

If you wrote that second line as `[view frame]`, the compiler wouldn't actually turn that into an `objc_msgSend` call, but rather invoke a lesser-known member of the `objc_msgSend` family.

`objc_msgSend_stret` is an alternate version of `objc_msgSend` that exists solely to return a struct value (the 'stret' stands for for **st**ruct **ret**urn). Other related functions exist for other primitive types, such as `objc_msgSend_fret` for floating-point numbers.

Trying to manually call `objc_msgSend_stret` isn't as simple as its more-common bigger brother. Even the initial act of figuring out its method signature is confusing: compare the signature suggested by Xcode's autocompletion with the signature given in the runtime documentation:

**CodeSense**



**Inline Documentation Viewer**

![image](http://cl.ly/image/0f3q1Y1y0D3W/Screen%20Shot%202013-10-12%20at%2024.42.18%20.png)

If you look at its declaration in `objc/message.h`, it becomes clear that the true signature is the former. But this line of code will also trigger a compiler error.

```
CGRect frame = objc_msgSend_stret(view, @selector(frame));
```

`objc_msgSend_stret` has a return type of void, which is obviously not a CGRect. And you can't just cast the return value to a CGRect and call it a day.

The problem is that `objc_msgSend_stret` exists to do a task that isn't expressible in C (mind blown, right?). It defines a function that returns an arbitrary C struct, whose type won't be known until runtime; C doesn't have a way to express that for non-pointer types.

The solution? You need to cast the `objc_msgSend_stret` function itself into a function whose return type is the struct you're expecting. Here is a complete, functioning version of our example:

```
UIView *view = [[UIView alloc] initWithFrame:CGRectZero];

CGRect (*sendRectFn)(id receiver, SEL operation);
sendRectFn = (CGRect(*)(id, SEL))objc_msgSend_stret;
CGRect frame = sendRectFn(view, @selector(frame));
```


Pretty crazy, right?
