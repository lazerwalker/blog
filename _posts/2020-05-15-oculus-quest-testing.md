---
layout: post
title: "How to easily test your WebVR and WebXR projects locally on your Oculus Quest"
date: 2020-05-15 12:00
comments: true
---

Lately, I’ve been spending a lot of time prototyping VR games using [Babylon.js](https://babylonjs.com/). I love how technologies like Babylon and the WebXR API let me build VR experiences with the quick iteration time of modern web dev, rather than the slower compilation loop of something like Unity.

That said, until recently there was one part of my development work flow that annoyed the heck out of me!

I do most of my testing on an Oculus Quest, and development on a Mac. Both the WebVR and WebXR APIs require that you access them from a webpage being served over HTTPS, rather than non-secure HTTP, with most browsers adding an exception for `localhost`.

Because I’m on a Mac, I can’t set up my Oculus Quest via Quest Link to act like a desktop headset connected to my computer. There also isn’t really a way to set up a local desktop computer to properly serve files over SSL / HTTPS.

This leads to a hard question: how the heck do you actually test your game locally on an Oculus Quest?

A lot of the time, this isn’t an issue. I can test in a 2D browser on my dev machine. If I need motion controllers, I can push my working code to a remote server to load from the Quest, or I can use something like [Ngrok](https://ngrok.io/) to get an HTTPS URL that redirects to my local machine.

But all of these feel like hacks, and make it slower for me to test what I’m working on. Which sucks when one of the big appeals of WebXR is how fast your iteration loop can be!

It turns out it’s pretty straight forward to get a more functioning workflow. I’m going to walk you through setting up your Quest for development as an Android device, and then configure Android port forwarding so that you can access a web server hosted on your computer as `localhost` from your Quest, letting it properly enter WebVR or WebXR mode.

## Setting up your Quest for development
Although we’re interested in using an Oculus Quest to build web-based content, rather than building natively using something like Unity, you still need to set it up for development as if that’s what you’re doing.

Follow the instructions on the Oculus support site to [set up a Quest for development](https://developer.oculus.com/documentation/native/android/mobile-device-setup/). You’ll need to create a development organization to add your Oculus account to, and then enable Developer Mode in your Quest’s settings or in the Oculus app on your phone.

## Install the Android SDK Platform Tools on your computer
At this point, your Oculus Quest is able to enter development mode, which means most Android software development tools can talk to it.
We specifically want to use the `adb` (Android Debug Bridge) CLI tool , which gives us the ability to interact with the Quest in a bunch of helpful ways.

You can get `adb` by downloading and installing the [Android SDK Platform Tools](https://developer.android.com/studio/releases/platform-tools). If you’re on a Mac and use Homebrew, you can also install it by running `brew cask install android-platform-tools`.

Either way, hopefully after installing the Platform Tools you should be able to run `adb` at a command line and see a whole bunch of documentation.

# Connect your Oculus Quest to your computer
You can use any USB-C cable, including the charging cable that comes with the Quest.

You’ll need to put the Quest on and accept a prompt to allow the computer to connect with it. I highly recommend checking the checkbox that skips this prompt in the future.

Once that’s done, run `adb devices` from the command prompt. You should see your Quest as the only device.

If multiple Android devices show up in that list (e.g. you have other Android devices plugged in with developer mode on), take note of the device ID that appears in the first column. When you run the `adb reverse` command in the next step, add in `-s DeviceId` as a flag to the command to specify you’re targetting the Quest.

## Enable port forwarding
Conceptually, what we want is simple. Any time you browse to a given local port on your Quest (e.g. `http://localhost:1234`), we want to forward that to a port on your computer. Fortunately, `adb` has built-in support to do this sort of port forwarding!

I’m assuming you already have a local web server on your computer that’s serving your WebVR or WebXR project. Note what port that is running on. As an example, my project setup tends to run a server on port 3000, or `http://localhost:3000`.

Within `adb`, what we’re doing is called “reverse port forwarding”. Regular port forwarding means we would be forwarding a port from our computer to a port on the Quest. But we’re trying to do the opposite — route from one port on your Quest’s localhost back to one on your computer — so that’s considered “reverse” forwarding.

If you know what port you need to forward, you just need to run `adb reverse tcp:PORT tcp:PORT` and `adb` will take care of the rest. For my server running on port 3000, for example, `adb reverse tcp:3000 tcp:3000` connects things properly so that going to `http://localhost:3000` in the Oculus Browser (or Firefox Reality) properly routes to the web server running on my computer, and should allow for entering VR mode.

You can safely close your command prompt and forget about `adb` for the rest of your test session, although you’ll need to rerun `adb reverse` the next time you disconnect and connect your Quest.

## Go make cool things!
And that’s all there is to it!

It’s theoretically possible to set this up to work wirelessly, but in practice I wasn’t able to get it to work. `adb` can successfully connect to my Quest over WiFi, but `adb reverse` doesn’t work. There have historically been issues with `adb reverse` and WiFi connections; it seems like they may have been solved in recent versions of Android, but (at the time of writing) Facebook’s fork of Android may not have pulled in those fixes yet. Let me know if you manage to get WiFi working!

In any case, you should now be able to debug your web VR projects on-device without needing a desktop HMD or deploying your code to a server! I hope that wasn’t too painful to set up, and I hope this little trick can help improve your daily development workflow as much as it did for me.