---
layout: post
title: "Wikipedia SF Hackathon! BERLIN HO!!!"
date: 2012-01-23 11:26:29 +0000
categories: ["curiosity", "projects"]
tags: ["hackathon", "heroku", "parisoma", "ruby", "san francisco", "sinatra", "twilio", "wikimedia foundation", "wikipedia"]
comments:
  - id: 2412
    author: "Doug Mahugh"
    author_email: "dmahugh@microsoft.com"
    author_url: "http://blogs.msdn.com/b/dmahugh/"
    date: "2012-01-23 04:28:06"
    content: |
      Congratulations, Judy! Loved your demo -- I think if the winner were chosen by a simple decibel meter you'd have won 1st place then, too, for the reaction when you held the mic up to your phone as it was reading the Wikipedia entry for the text message you had just sent. :) Enjoy Berlin!
  - id: 2413
    author: "Sarah Stierch"
    author_email: "sstierch@wikimedia.org"
    author_url: "http://en.wikipedia.org/wiki/User:SarahStierch"
    date: "2012-01-23 08:15:44"
    content: |
      Really awesome post - it got me psyched and I don't even know how to code! Congrats on a great event and winning "first prize," what a cool opportunity. I can't wait to see it (and use it!). Perhaps we'll see you at Wikimania? :)
  - id: 2414
    author: "Rosemarie McKeon"
    author_email: "rosemarie.mckeon@gmail.com"
    author_url: "http://www.linkedin.com/in/rosemariemckeon"
    date: "2012-01-23 13:11:01"
    content: |
      Hey Judy, 
      What a great summary of the Wikipedia Hackathon weekend. Your team's "Wikipedia page reading phone app" is fabuloso. I loved your demo. Please share when it goes public.
      
      I think your application will provide access to Wikipedia from searchers/editors in communities that lack or have limited internet connection on Native American reservations. What about accessing Wikipedia from landlines? Has that been done or can you include such a thing?
  - id: 2415
    author: "judytuna"
    author_email: "judytuna@gmail.com"
    date: "2012-01-23 14:38:55"
    content: |
      Thanks Doug! It was great to meet you and Ben and find out more about Microsoft's interop bridges. Your work &amp; work like http://blogs.msdn.com/b/kinectforwindows/archive/2012/01/12/the-power-of-enthusiasm.aspx is so good for developer confidence (I'm also <a href="http://www.women2.org/words-with-bears-wins-women-2-0-startup-weekend-2011/" rel="nofollow">building a Kinect app</a>!). Hooray!
    parent: 2412
  - id: 2416
    author: "judytuna"
    author_email: "judytuna@gmail.com"
    date: "2012-01-23 14:45:05"
    content: |
      YES, that's one of the biggest features we want to race to next--doing the whole interaction within one call. I know that Twilio can record and transcribe and then do something with the transcription, but I don't know (yet) if it can do it on the fly. Even if it has to call you back, though, it would be great to have functionality that doesn't require texting. There are really hard things about it ... like, our app right now is VERY simple and doesn't have disambiguation yet (it doesn't even handle incorrect caps yet haha) and if we did speech-to-text, it would definitely have to have disambiguation in place.
      
      I remember as a kid, there was a phone number you could call that would connect you to your local library, and there would be an answering machine recording of someone reading a storybook. They'd change out the recording every week. I thought it was really cool. Imagine if we could do this for Wikipedia, too. There could be a separate number for the Simple English wikipedia geared towards younger kids!!!!! Maybe it would serve up a random article~!!!!!! omg!!!!!!
    parent: 2414
  - id: 2418
    author: "kevin"
    author_email: "kevin@interi.org"
    author_url: "http://malmater.com"
    date: "2012-01-27 17:26:17"
    content: |
      http://www.youtube.com/watch?NR=1&amp;feature=endscreen&amp;v=808953UNIE0
  - id: 2419
    author: "judytuna"
    author_email: "judytuna@gmail.com"
    date: "2012-01-29 21:45:45"
    content: |
      HAHAHAHAHAHAHA
    parent: 2418
---

I went to the [Wikipedia SF Hackathon](http://www.mediawiki.org/wiki/San_Francisco_Hackathon_January_2012) this weekend at [Parisoma](http://www.parisoma.com/)! [Neil](http://brevity.org) and I coded a phone gateway for [the English Wikipedia](http://en.wikipedia.org/) on [Twilio](http://www.twilio.com). You send it a text with your search query (like "Barak Obama" or "Seattle") and it calls you back in a few seconds and reads you the entire text of the article. =D

CODE: [https://github.com/judytuna/SMS-Wikipedia](https://github.com/judytuna/SMS-Wikipedia) -- it calls the Twilio API, in [Ruby](http://www.ruby-lang.org/en/), using [Sinatra](http://www.sinatrarb.com/), hosted on [Heroku](http://www.heroku.com). I wouldn't have been able to do any of this if Twilio (the amazing [Sasha](http://www.meetup.com/Women-Who-Code-SF) is the best developer evangelist ever), Ruby (sfruby.info like woah), and Heroku (who sponsored one of my early wwcode-rails meetups, and also sponsors [Blazing Cloud](http://blazingcloud.net) [sponsorships](http://blazingcloud.net/training/)!) didn't have the community presence that they do. Seriously, I can't believe I get to live in San Francisco where all of this is happening RIGHT NOW. Look at this technology! Look at what it's enabling us to do! 

Romy wrote super-comprehensive notes on our product and process and drew pictures here: [http://www.mediawiki.org/wiki/San_Francisco_Hackathon_January_2012/Teams#Wikipedia_SMS_.2B_IVR_on_Twilio](http://www.mediawiki.org/wiki/San_Francisco_Hackathon_January_2012/Teams#Wikipedia_SMS_.2B_IVR_on_Twilio)

On Thursday, I had gotten an email urging us to check out the project ideas, and came up with the SMS gateway idea and added it to the project page. 

Why did I want to do this so badly? - I didn't have a smartphone until December and always wished I could look stuff up on Wikipedia when I wasn't near a computer.
 - When we get phone tree stuff working, this could be used by illiterate or blind people.
 - In areas where access to tech is low but phones (not smartphones) are ubiquitous, this could be a way for people to look stuff up on wikipedia. This is mind-blowing.
 

It was an amazing experience and I learned so much from Neil and **our team won first place**!!!!!! The prize: flight and hotel to another wikimedia hackathon. The next one will be in Berlin in May!!!!!!!!!!!!! I've never been to Berlin! I've been to Europe once--London and York, with my high school choir, in 2000. 

We have lots of ideas for the next steps of this app. I am considering setting up a kickstarter (as long as it's okay with the wikimedia foundation??) to pay twilio for the app (actually I have no idea about this...)... It's still in the "twilio sandbox" for now so I can't show it to you yet (because your number has to be a "verified number" for MY twilio account in order for it to call you back I think). But I'm about to put my credit card info in so I'll be able to show it off to the world soon. 

The app definitely works =)

At the Hackathon, I REALLY enjoyed [the PhoneGap demo](http://www.mediawiki.org/wiki/San_Francisco_Hackathon_January_2012/Mobile_tutorial). [Tomasz](http://www.mediawiki.org/wiki/User:Tfinc) and [Yuvi](http://www.mediawiki.org/wiki/User:Yuvipanda) showed us [the Wikipedia app](https://market.android.com/details?id=org.wikipedia) that they just pushed to the Android store last week, and guided us through adding a menu item. js! css! wow!!! I think the tutorial that they used would be ideal for a Railsbridge-style workshop (it starts with "how to get stuff installed" and it was surprisingly fast and easy).

So PhoneGapBridge is incoming. I'll plan it 2 weeks off of a Railsbridge. =D

I'm learning so much. I met so many amazing, amazing people. I got interviewed by Wikimedia Foundation Storyteller [Victor](http://en.wikipedia.org/wiki/User:Victorgrigas)--how cool is his job title? I got my picture taken [with leaves](https://judytuna.com/2012/01/wikipedia-sf-hackathon/img_9187/). I told him that I had serious class issues and loved online communities and want everyone to have access to information and nothing scares me more than loss of free speech and was generally completely incoherent but I kept banging on my knees the whole time because of HOW EXCITED I AM.

[caption id="attachment_1582" align="alignnone" width="200" caption="I am a dork"]![Judy with Leaves](https://judytuna.com/files/2012/01/IMG_9187-200x300.png)[/caption]

I wondered where I'd seen Toki Wartooth Brandon and then realized this morning that it was the fundraising banners! I basically couldn't believe I was there all weekend. They're right here in San Francisco! 

I told everybody who would listen about Lukas and Elsa's Occupedia, which is an initiative to create meetups that encourage underrepresented groups to contribute to wikipedia. Lukas [wrote about the first event](http://crashopensource.blogspot.com/2012/01/occupedia-women-contributing-to.html) and I showed everybody haha. 

I fucking love wikipedia. I love the wikimedia foundation. I want more. I was talking to [Daniel](http://www.mediawiki.org/wiki/User:Duesentrieb) from Germany, who said "I want to see a separate mobile app for a different set of users -- the ones that spend a lot of their idle time patrolling new edits. There should be an app that lets them to it easily at the bus stop." PHONEGAP HOOOOOOOOO

[Sumanah](http://www.mediawiki.org/wiki/User:Sumanah) was amazing and kept things going and was crazy and enthusiastic and welcoming. I met [Leslie](http://www.mediawiki.org/wiki/User:LeslieCarr), a network engineer, who knew someone else that I knew from Railsbridge. I talked to Danielle (women in tech!), Elizabeth (Android!), and Rosemarie (who I'd met at wwcode-rails!). [Phil](http://www.mediawiki.org/wiki/User:Pchang) asked me how I was going to pay Twilio for it D: I learned about Microsoft's [bridges with open source](http://www.interoperabilitybridges.com/) from [Ben](http://ben.lobaugh.net/) and [Doug](http://blogs.msdn.com/b/dmahugh/) and it was fascinating and I tried asking them about [openkinect](http://openkinect.org)/[k4w](http://www.microsoft.com/en-us/kinectforwindows/), but their department doesn't interface with xbox stuff =) I met Rupa of [CodeChix](https://sites.google.com/site/codechix/) and there are machinations afoot. 

AAHHHHHHH!!!!!!!!!!!!! I AM SO EXCITED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!