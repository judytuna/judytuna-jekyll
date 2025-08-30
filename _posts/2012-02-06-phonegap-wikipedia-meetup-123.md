---
layout: post
title: "PhoneGap + Wikipedia meetup (1/23)"
date: 2012-02-06 02:55:08 +0000
categories: ["curiosity", "notes", "projects"]
---

I went to the [PhoneGap + Wikipedia](http://www.meetup.com/PhoneGap-SF/events/39447102/) event at Adobe immediately after the [Wikipedia hackathon](https://judytuna.com/2012/01/wikipedia-sf-hackathon/). I heard about it that Monday in the irc room O_O and thought initially that I couldn't go, because I usually have Spot the Octopus rehearsal on Mondays... but that week, some Spots were sick and others out of town, so I decided to attend the meetup instead. And I'm glad I did -- we got more info directly from Tomasz and Yuvi about why we should care about a Wikipedia phone app, why they're using [PhoneGap](http://phonegap.com/) plus what they learned, and next steps. MOST interesting: how they're encouraging editors to edit by using location and presenting them with "articles around you that need improvement"!!!!!

Here are official links to [slides](http://wikitech.wikimedia.org/index.php?title=File:PhoneGapMeetup_2012_-_Wikipedia_Android_PhoneGap_-_Tomasz_and_Yuvi.pdf&page=1) (via [@WikipediaMobile](https://twitter.com/#!/WikimediaMobile/status/161913349297283072)) and [video](https://my.adobeconnect.com/_a295153/p9lmqviaxen/) (via [@stevesgill](https://twitter.com/#!/stevesgill/status/162247607308140544)). =D

I was also super-excited that someone asked a question about easily surfacing the content of a page. She was interested in making the content more accessible, because people today are overwhelmed by all these tags and information. Tomasz even got a microphone over to me so I could say how Neil and I did it in our app (we used parse, not query, and regexed out all the html tags, and Neil thought of taking out everything in tables to skip the infobox! haha. It's a bit hacky still.) And when I sat down, my phone vibrated, and there was a tweet from Words With Bears teammate [Jen](http://www.jenniferarguello.com/) saying that she'd [seen me on the livestream](https://twitter.com/#!/engijen/status/161657548599070720)... haha!

Then I talked to Hearplanet, which is providing text-to-speech MP3s of places of local interest for tourists/city explorers. They're using Wikipedia as one of their channels of information. Fascinating.

My notes from Tomasz's and Yuvipanda's talks are below / through the jump!

weinre
WEb INspector REmote (phone)
debug.phonegap.com - gives you a full instance of that browser
used to be in webibl? now in coffeescript

html5 
- ios: titlebar and tabbar
- android creaets a native menu
…i missed the third

apache cordova plugin vs project? now everything is a plugin
- geolocation (in the web browser). native geo that ships w/ the browser
- [github.com/phonegap/phonegap-plugins](github.com/phonegap/phonegap-plugins) lots there

a phonegap made of only the apis you want

phil - wikimedia zero, where data from wikipedia is free in africa (orange)
---my own thought: maybe twilio could do a similar thing

tomasz:

why an app?
- wikipedia != ads and there are other apps that show ads D: 
- wikipedia on every phone. we work with carriers all the time and we want the app to come pre-installed. provide free access to information (no ads)

free open interoperable 
simplify all the interfaces that are available. project wants to push standards adn simplify. "the purpose of phonegap is for phonegap to not exist"

android app
droid@screen  - lets you connect your android to your computer with a cord and it'll show your droid's screen. demoing with the emulator sucks and is slow. 

yuvi:

what went well?

reuse
1. jQuery
2. Localization libraries - message / tags
plugin re-use
appmenu, urlcache, sharing, globalization, toast (notification system that android gives you), webintents, other ios specific plugins
- all the things that web browsers shoudl do but don't yet, we do with plugins

contribute back
- plugins

per platform overrides
- app code is always 'general' can run anywhere
- platform specific overrides deal with idiosyncracies
- different plugins in android and ios. separated. menus working everywhere.

lowering the barrier to entry for vounteers
https://github.com/wikimedia/WikipediaMobile
- new people were able to contribue production-quality code fast
- time to pull request is under a day

what sucked?

debugging is a problem 
- the one thing that is missing is you can't do script(???) (strip? what?) debugging. have to do printfs. if you're coming from web or c it's a pain. in ie you don't have winery but you don't have console.log.  
the app: you can run it in safari. or chrome with web security disabled. and it works. can't test phone-specific stuff in there but since we keep phone-specific stuff separate, we are able to run it in a proper desktop browser and test it that way if you were just working on javascript stuff. 

iframe bugs

scrolling bugs
- typical css scrolling not until ios5 and android 4. (very common thing of having one part of your app that stays there while you scroll). 
- webkit (newer versons of android) have these fixed

focus bugs
- if you have an input element and you have something on top of it, no matter what you do, the input element gets the focus. you cannot have ui elements on top of input. necessitate that lots of hack happen after every dom change, makes our code not cute D: also bugs without workarounds (had to take out the feature)

android core devs not caring (about webkit bugs)

zepto.js
- jquery-compatible library (you can think you're using jquery but it's smaller cuz it doesn't have all the ie stuff). waht that acutally means is that it's smaller (important for mobile device, bandwidth and memory). in theory, incredible idea but doesn't actually quite work. very subtly incompatible. ex jquery exacts(?) thing is missing (?)

pure js architecture - not mature enough, not many examples

problem w/ moble projects
- when people interact, look at this graph
participation -> quality -> reach

showcase 2 applications as part of the weekend code challenge (november of last year) - 
- built a phonegap-extended version of existing app that let you take pictures and add them to articles (for pipeline of contributing). not as interesting if you can only upload images.
- 2nd application - looks like nearby view in other apps, but shows you the articles near you that have problems. show to our mobile users - what's missing in wikipedia. it's difficult to figure out how to get involved (so many choices). so this is near you and missing images. build a contribution pipeline by building very specific calls to action. that's what we're showcasing now -- how people can get involved. 

one of the fundamentals to wikipedia is editing. 
- writen in mobile browsers, will be in apps in a few months. make the experience the same 

"let's push mobile contribution"

mobile-l@lists.wikimedia.org
tomasz@wikimedia.org
@wikimediamobile
http://meta.wikimedia.org/wiki/Mobile_projects
http://wikitech.wikimedia.org/view/Presentations

q: how to make accessible to audio-only ppl
a by tomasz: how do we surface that first paragraph as quickly as possible 
OMG I CAN'T BELIEVE THIS QUESTION IS BEING ASKED! I raised my hand and answered it by saying that you use the api with the "parse" action (instead of the "query" action) and get a json, then strip the html, and also strip everything in a table tag (cuz the infobox is first and in a table tag) -- then it'll start reading it from the beginnign of the article =D