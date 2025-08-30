---
layout: post
title: "xbox 360 controllers + wireless dongle + mac"
date: 2012-10-08 07:11:46 +0000
categories: ["coding", "xbox"]
---

Peterson and I are here at the dinner table with my Microsoft wireless controller dongle and two wireless xbox360 controllers. 

http://www.maclife.com/article/howtos/how_use_xbox_360_wireless_controller_your_mac led us to http://tattiebogle.net/index.php/ProjectRoot/Xbox360Controller/OsxDriver … and the source is available! It is made up of … a lot of xcode projects.

I’d used the tattiebogle.net driver before, on the day I saw that Microsoft was making the dongle again (they stopped making it for a few years, and Amazon was rife with fakes) when I was at Best Buy looking for something else, and had to get it. I played with it and ControllerMate a little bit that day, but didn’t get ControllerMate to successfully map to any keys. 

We ran the tattiebogle driver again on Peter’s computer tonight, and one of the things the driver does is activate the rumble packs when you depress the triggers. We noticed that one side’s rumbling is much stronger than the other, so I asked the internets for information. http://www.ifixit.com/Guide/Installing-Xbox-360-Wireless-Controller-Vibration-Motors/3292/1 is like looking at porn! It does say that “The right motor has significantly more counter-weight than the left motor.”

Then I remembered that a few weeks ago Brycolyn gave us some guitar hero peripherals they’ve had lying around their house from a former roommate (they don’t have an xbox360 anymore). We got them out of the trunk.

Then there weren’t any AA batteries around, so we went to Lucky to get a whole bunch. I am now 48 Sunny Select brand AA batteries richer (plus some almond milk, ling ling potstickers, some paper towels, and some orange juice).

The guitars connect to the dongle just fine, and we’re messing around with the buttons. A, B, X and Y are what you expect (and what you know if you’ve navigated menus in rock band or played regular xbox games with your guitar as a controller). The interesting part is that it SEEMS that there’s an accelerometer or a gyroscope or something in the guitar–when you tilt it up, what the driver thinks is the right-side joystick changes position in accordance to the attitude of the device. When you shake it around, you can see it moving. When you make a CHANGE in orientation, what the driver thinks is the right trigger gets depressed, and then when you stop moving it, it goes back down to a slightly jittery middle phase. Must be how it knows about star power when you tilt it up. Requires more investigation. 

I am also super tired. We went to Tahoe this weekend.