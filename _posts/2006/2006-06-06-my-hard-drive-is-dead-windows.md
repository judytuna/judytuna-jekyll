---
layout: post
title: "My hard drive is dead windows"
date: 2006-06-06 01:46:00 +0000
categories: ["Uncategorized"]
tags: ["computer woes"]
comments:
  - id: 1558
    author: "mbarrien"
    author_url: "http://mbarrien.livejournal.com/"
    date: "2006-06-06 16:29:45"
    content: |
      <p>Tip #1: Avoid Western Digital :-)<br />
      Tip #2: Avoid Maxtor too. They got bought out from Seagate a few months back, and they're firing nearly everyone from Maxtor and keeping all the Seagate employees, so don't expect much support from the company.</p>
      <p>Tip #3: Googling some more about "C:WINDOWSSYSTEM32CONFIGSYSTEM" brought up a few more possible things to do. Have you tried running "chkdsk /r" from the console? There's also some other locations to get an older copy of the system file to overwrite it. See  for instructions on copying a repair "system" file from C:WINDOWSREPAIR.</p>
      <p>Be warned that any of these "overwrite the system file" stuff is actually overwriting the windows registry, so it is likely you may lose any settings for programs that were stored in the registry. Hopefully though it'll be enough to recover your files. Worst come to worst, you can move the HD to another computer and recover the files that way.</p>
      <p>Some of the sites I read suggest that this can be caused not just by a bad HD but also by bad RAM or even a bad HD cable. Anything that can cause corrupt data to be written to disk would do it. If you have a chance, check that your RAM is good.</p>
  - id: 1559
    author: "judytuna"
    author_url: "https://judytuna.com/"
    date: "2006-06-06 21:24:34"
    content: |
      <p>I did chkdsk two nights ago, which said "volume appears to be ok so no check was completed. to check anyway, use /p." So i did chkdsk /p, which gave me "one or more errors was found on the drive." I didn't know about chkdsk /r. I'm running it now.</p>
      <p>How do I check that my RAM is good? </p>
      <p>If not WD or Maxtor, then who? Seagate? http://shop1.outpost.com/product/4596277</p>
    parent: 1558
  - id: 1560
    author: "berkeleyjew"
    author_url: "http://berkeleyjew.livejournal.com/"
    date: "2006-06-06 21:29:28"
    content: |
      <p>Try booting with one stick of RAM at a time, or in another machine entirely?</p>
    parent: 1559
  - id: 1561
    author: "mbarrien"
    author_url: "http://mbarrien.livejournal.com/"
    date: "2006-06-06 21:56:08"
    content: |
      <p>I dunno who's most reliable, and most of my Googling says that brand name doesn't really matter for drive reliability. Actually, a bunch of Western Digital drives were coming out on top.</p>
      <p>Perhaps you should buy a Hitachi hard drive, if only because they made that <a href="http://www.hitachigst.com/hdd/research/recording_head/pr/PerpendicularAnimation.html" rel="nofollow">Get Perpendicular</a> animation, and we need to encourage our tech companies to make more animations like it. :-)</p>
      <p>As for RAM testing, there's software out there that'll stress test the RAM, but I don't know any off the top of my head. I'd be Googling it. Google is an extension of my brain.</p>
    parent: 1559
---

My hard drive is dead: windows can't boot. It died last April, too--right before the 1-year warranty was about to wear out, so I sent it in and got a new one (of the same model). Western Digital. Lifetime of about a year.

The problem began yesterday with the wireless keyboard spontaneously quitting on me in Nef's room. Naturally, I thought it was a problem with the keyboard. Batteries purloined from Derek, a couple of restarts, and an old wired keyboard of Derek's later, I got:
"Windows could not start because the following file is missing or corrupt:
C:WINDOWSSYSTEM32CONFIGSYSTEM

You can attempt to repair this file by starting Windows Setup using the original Setup CD-ROM.
Select 'r' at the first screen to start repair."

The setup CD (again Derek's) doesn't show any repair options when I examine the hard drive. The repair console (which is what you get when you press 'r') is really a console and as such is intimidating; I followed some directions from sites such as http://www.michaelstevenstech.com/XPrepairinstall.htm#warning2 (thank you Google, thank you Ryan's powerbook, and thank you Ryan) and nothing worked, not even changing the attributes of boot.ini, deleting it, and manually copying over some files from the setup CD to the windows system folder. Soooo... I'm in the market for a new hard drive. Any tips?