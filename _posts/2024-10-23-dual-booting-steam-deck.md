---
layout: post
title: "Notes on Dual-Booting Windows on Steam Deck"
date: 2024-10-23 19:00
comments: true
---

After completing [hardware modding my Steam Deck](https://blog.lazerwalker.com/2024/10/06/steam-deck-mod.html), I decided to move onto the next task on my to-do list of making my Steam Deck the ultimate gaming handheld PC: dual-booting Windows.

 I would describe the process as "straight forward, but poorly documented", so this walkthrough of what I did may hopefully transform it into merely straight forward.

To be explicit, I replaced my stock 512gb SSD with a 1tb SSD (any M.2 2230 NVME disk should be compatible), and set it up so that I have both SteamOS and Window running side-by-side as separate partitions, with a boot selector on power-on.

You can also install Windows onto a microSD card or an external hard drive, but the former is slow and the latter sounds rather unportable for a handheld. 

## Do you actually want Windows?
Let me be blunt: Windows kinda sucks on the Steam Deck. The OS itself works shockingly well: touch support is great, and it's easy to get the controller working both inside and outside of Steam. But every single game I've tried playing on both SteamOS and Windows, the SteamOS/Proton version was meaningfully more performant.

I am happy I have Windows installed, but it solely exists to run games I can't run in SteamOS (such as Destiny 2) and Game Pass games. That isn't to say you shouldn't install Windows, but temper your expectations accordingly, and perhaps weigh that as you decide what your partitioning strategy should be for your precious disk space. 

## A few notes and warnings
I'll walk you through everything I did step-by-step, but a few general notes beforehand.

#### YMMV if you have a Steam Deck OLED
Everything I'm writing about is from my experience with an LED Steam Deck. The Steam Deck OLED is subtly different. I think it's likely that this process will be exactly the same (except for downloading different Windows drivers from Steam, they have a different page for OLED drivers), but I cannot confirm that.

### Display rotation
The Steam Deck display's native orientation is in portrait mode, with the bottom of the display on the side of the face buttons. Most boot disks we'll be using will recognize this and eventually rotate the display back to its "proper" orientation, but don't be surprised if you have to spend some time holding your Steam Deck in portrait mode.

Most notably, the Windows installer will be entirely in portrait mode, and once you have a functioning Windows install you'll manually need to go to display settings and rotate your display.

###  How to select your boot disk
You will often need to boot from removeable media (e.g. a USB thumbdrive or microSD card). To select the boot disk on your Steam Deck, you have two options:

If you hold down the volume down key, press the power button, and then release the volume down button when the boot splash screen appears, you will be prompted with a screen that lets you select the boot disk (or network boot, if you have an ethernet connection via USB-C dock).

If you hold down the volume up key instead of volume down, but otherwise perform the same sequence, you will be placed into a more full-featured boot manager that lets you select a boot device, boot from file, or a few other options.

Throughout this post, it's understood you know how to do this. Either method is fine for booting from an external USB drive or microSD, and there is exactly one instance where you may optionally choose to boot from a file instead (which requires the vol up option).

### Have a keyboard handy
You will frequently be entering long console command strings. I recommend having an external keyboard plugged in for this whole process to make things easier, especially since in some situations (e.g. the Windows 11 installer) on-screen keyboard support may be shakier than you'd like. I didn't find a mouse was strictly necessary, as you will usually have touchscreen (and sometimes trackpad) support.

### Windows 10 vs 11
You can choose to install Windows 10 instead of 11, but Windows 11 has much more robust touch screen support. 

Some people say Windows 11 on the Steam Deck doesn't play nicely with some anticheat software. I can successfully run Destiny 2 in my Windows partition (which uses Battleye, and doesn't run in SteamOS due to it explicitly blocking Proton Battleye workarounds), but I have not tried more severe anticheat such as Riot Vanguard. The "SteamDeckTools" utility notes that some of its features may trigger anticheat, but that functionality is clearly labeled and not enabled by default.
### The Steam Deck Recovery Image
Several steps in this process reference the Steam Deck Recovery Image, a bootable live restore disk you can [download from Valve](https://help.steampowered.com/en/faqs/view/1b71-edf2-eb6d-2bb3) and flash with your preferred USB flashing tool (Valve's download page has recommendations for every OS; I used the recommended Balena Etcher on macOS).

As a major warning: this recovery image is weirdly fiddly. I tried flashing it to several different USB thumb drives, and none of them worked (failing with various cryptic and unhelpful errors during the boot process). I have had 100% success flashing this to a microSD card and booting from that, so that would be my strong recommendation. Any other bootable images you will need to use for this process (the Windows installer, optionally GParted or CloneZilla) should work fine off of any old USB thumb drive or microSD, they won't be as weirdly picky.

Additionally: in my experience, any drive flashed with the recovery image seemed to fail to become a valid boot disk once it has successfully been used to boot the Steam Deck once. I'm not sure the cause of this, but be prepared to potentially flash the image several times.

### Shared Partitions and MicroSD Cards
I initially set up my SSD to have two small partitions for SteamOS and Windows, and one large shared NTFS games partition. This ended up not working -- while the NTFS drive would automount in SteamOS, Steam would silently fail to let me add its steamapps folder as a new storage location for my library.

I'm not sure of the source of my issues, but I've since heard from other folks that sharing a single library directory between Proton and Windows can cause issues and conflicts. In my case, since I concluded my use of Windows is going to be more limited anyway, I settled on a small Windows partition large enough to fit my anticipated Windows game usage and a larger SteamOS partition.

I'm told you may have more luck sharing partitions or microSD cards across OSes if you format them as btrfs, although Game Pass games on Windows will not install to a btrfs volume. I have not tested this myself yet.

## The install process
### Preparing a new SSD
I'm not going to give instructions about the physical act of installing a new hard drive, it's fairly straight-forward and there are guides out there (I'd check [iFixit](https://ifixit.com)). If you're using your stock hard drive, you can obviously skip this, although if you find yourself unable to shrink your home partition as much as you'd like you may benefit from wiping it to a fresh install via the recovery disk.

The most straight-forward way to initialize a new hard drive is to install your new SSD, flash the official Steam Deck boot recovery disk onto a microSD card, and use it to reimage your new SSD. Unless you have a concrete reason to clone your existing drive, I'd start this way. The most straight-forward path is probably just to install the new SSD and then run that.

If you want to copy your existing SSD, I'd recommend grabbing an external M2 SSD enclosure (make sure to grab one that supports 2230, the small and slightly less-common form factor Steam Deck SSDs use), write the live-USB version of [CloneZilla](https://clonezilla.org/clonezilla-live.php) onto a USB drive or microSD, and use that for an easy way to make a 1:1 copy. 

When I used CloneZilla, my resulting clone ended up having some odd issues (the microSD card would auto-mount in SteamOS, but Steam wouldn't recognize its installed Steam library until I went to Desktop mode and manually re-added the drive to my Steam library every single boot), and I ended up wiping it clean and starting over as the simplest debug option. I wouldn't necessarily recommend cloning your old disk, unless you have a very specific reason to not just start fresh.

### Partitioning
To install Windows, you need to have a partition set up on your SSD for Windows. Some people have found success using the KDE Partition Manager within SteamOS's desktop mode, but I was limited in how much I could shrink my active /home partition this way.

Instead, boot into the Steam Deck Recovery Disk and use the partition manager that way (System -> KDE Partition Manager).

If you can't get a copy of the Steam Deck recovery boot image working (this was my situation!), you can also use a GParted live USB install, and that live disk should be less sensitive to the device you're using than the Steam Deck Recovery Disk. At the time of writing, the most current release (1.6.0-10) would not boot on a Steam Deck, but (discovered thanks to a Reddit comment) the older [1.6.0-3 release](https://sourceforge.net/projects/gparted/files/gparted-live-testing/1.6.0-3/) does boot on a Deck. That said, you will benefit from having a working recovery boot image later in this process, so I'd probably honestly just get it working for this step.

A vanilla Win11 install takes about 32gb once completed, although I'm told you probably want closer to 64gb as a minimum to account for OS updates, etc.

### Installing Windows
There's nothing particularly Steam Deck-specific about this step. Grab an [official x86 Windows ISO](https://www.microsoft.com/en-us/software-download/windows11/),  flash it onto a USB drive (on a Mac, I recommend [WinDiskWriter](https://github.com/TechUnRestricted/windiskwriter) with the default settings, as Balena Etcher won't work), boot to that drive, and run the installer. Expect the installer to be rotated 90 degrees, and an external keyboard may be helpful.

When selecting a partition, even if you used GParted or KDE Partition Manager to create an NTFS or other Windows-friendly partition, you'll need to delete that partition in the installer and let Windows recreate it.

After installation is complete, rebooting your Steam Deck will always reboot you into Windows. We'll fix that after we're done setting up Windows.
### Setting up Windows
At this point, you should have a more or less functional Windows install. There's a whole bunch of drivers and tools to install to make your experience better:

- The official [Steam Deck drivers](https://help.steampowered.com/en/faqs/view/6121-ECCD-D643-BAA8) will provide better performance. Install all of them except for the WiFi drivers (the next step is installing better-performance alternative WiFi drivers)
- The aforementioned [improved WiFi driver](https://github.com/ryanrudolfoba/SteamDeck-Windows-WiFi-Fix>)
- [Steam Deck Tools](https://github.com/ayufan/steam-deck-tools) provides a number of tools you may find useful (e.g. fan control), but I primarily use it as the easiest way to expose your Steam Deck's controller as a generic Xbox 360 controller to non-Steam games. Partway through, this installer will also require you to install the Microsoft Visual C++ Runtime. The installer will give you a direct download link; install it, and then re-run the Deck Tools installer
- You will eventually install Clover, a polished boot manager. There are two Clover config steps that need to be done in Windows, and it's convenient to do them now while you're already here. Go to [this automated setup script](https://github.com/ryanrudolfoba/SteamDeck-Clover-dualboot), and execute the two commands that need to be performed in an elevated Windows command prompt (a `bcdedit.exe` command and a `reg add` command). Don't do any other Clover setup yet, we will need to fix an issue where the latest build of Windows 11 (24H2) has destroyed your SteamOS boot config.

There are a few other classes of tools and tweaks I haven't experimented with yet:
* [Bald Sea Lion's guide](https://baldsealion.com/Steam-Deck-Ultimate-Windows-Guide/Windows-OS-Tweaks.html) has a bunch of tweaks you might consider, but it does seem a bit outdated (e.g. I have yet to have any issues with hibernate/sleep, despite not running their suggested fix):
* This [Reddit thread](https://www.reddit.com/r/WindowsOnDeck/comments/wn3x05/windows_on_deck_faq_aims_to_be_constantly_updated/?utm_medium=android_app&utm_source=share) also has other tweaks
* In general, it may be worth looking up guides for debloating Windows 11

### Fixing The GRUB Partition Table
In theory, you can boot into SteamOS at any time by launching the boot menu and selecting the correct partition.

In practice, assuming you have installed the 24H2 built of Windows 11 (the version released in the second half of 2024), the Windows installation nuked your disk's grub partition table, which will prevent you from booting into SteamOS.

While we will install Clover shortly (a boot manager that lets you easily select whether you want Windows or SteamOS on boot), you need to start by fixing your SteamOS installation and making it bootable again.

To confirm this is the issue you're happening, load the boot menu, and try to boot from your SteamOS partition. Instead of loading SteamOS, you should be presented with a GRUB terminal in portrait orientation

You can also determine this by loading the full boot manager (vol up on boot instead of vol down), selecting 'boot from file', and loading `ESP (the first option) -> efi -> steamos -> steamcl.efi`. The result should be the same.

Conceptually, Windows has corrupted your disk's partition mapping for grub, but there is a backup partition table that will still be valid, so you need to restore the backup.

To fix this, I followed [this video](https://www.youtube.com/watch?v=eUDbLkHDeGY&t=214s), but for your sake here's  written instructions loosely transcribed from the video:
1. Confirm you're experiencing the expected issue 
2. Boot into the trusty Steam Deck Recovery Key, and open a console (System -> Konsole)
3. Run `lsblk`, and note that `nvme0n1` (your internal SSD) has no partitions listed
4. Run `sudo fdisk -l /dev/nve0n1`. It should inform you in red text "The primary GPT table is corrupt, but the backup appears OK... so that will be used".
5. Run `sudo fdisk /dev/nvme0n1`. You will see the same error, and be given an interactive prompt
6. Type `p` to print the partition table. You should now see a list of proper partitions on your disk
7. Type `w` to write the partition table and quit `fdisk`.
9. Run `lsblk` again. You should see several partitions for your internal SSD now.
10. If you turn off your Steam Deck and attempt to boot into either your SteamOS partition or the steamcl.efi file, it should work!

(These instructions mimics the linked video . Do you actually need to call `lsblk` at all, or run `fdisk -l` before the interactive `fdisk` session? Probably not, but it can't hurt to triple-check your partition table.)

### Installing Clover
At this point, your Steam Deck is capable of booting into SteamOS, but will boot into Windows by default, and you can only boot into SteamOS via the rather annoying process of revealing the system boot manager.

Clover is a nice friendly boot manager GUI that looks like the sort of interface you're probably used to if you've dual-booted before. There's a competing boot manager that provides a similar experience, but I was told by a friend that Clover is slightly nicer, so I just picked it and didn't think too hard.

The instructions for [this automated setup script](https://github.com/ryanrudolfoba/SteamDeck-Clover-dualboot)) are good. If you followed along with this blog post, you have already run the instructions that take place in Windows. This script did not in fact pop up a GUI setup menu for me, and did not give me the opportunity to set the default OS to Windows, but this was fine since I wanted SteamOS to be the default anyway.

## And that's it!
At this point you should have a fully-functioning dual-boot setup. Have fun!