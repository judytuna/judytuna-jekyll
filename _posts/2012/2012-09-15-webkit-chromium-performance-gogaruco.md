---
layout: post
title: "webkit/chromium performance @gogaruco12! Cargo Cult Web Performance Optimization – Ilya Grigorik"
date: 2012-09-15 01:05:41 +0000
categories: ["coding"]
tags: ["conference", "gogaruco12"]
---

https://twitter.com/igrigorik

Ilya Grigorik

rough notes

Cargo Cult Web Performance Optimization

3 major components

netowrk

server

browser execution

server – rails app server

network – shows different & moving components in the network stack. look at some things chrome does for htis

browser execution

network stack: an average page has grown to 1059kB (over 1MB!!!) and is now composed of 80+ subresources

dns prefetch – good idea until you do wikipedia. need algorithm to see which host you need to preresolve

tcp preconnect – preresolve the hostname but perhaps we can also open up the connection and keep it idle so when you click the link it’s already there (another 50-100 ms)

pooling & re-use – leverage keep-alive, re-use existinc onnections

caching – fastest request is request not made

chrome does somethign specific – it learns the subresources as well. you go to cnn.com, the first time you come to cnn.com, the browsesr has to load all the resources, contact over 30 hostnames, will remember all those hostnames, next time you come back it’ll remember — let me try to preconnect to those as well. builds this giant hash map, it keeps track of all the requests and whether any of these succeeded. keep track, confidence intervals for each connection we make. hlelp hide some of the latency. 

some examples // snippets from actual source code

enum ResolutionMotivation {

  MOUSE_OVER_MOTIVATED, //mouse-over link induced resolution

  OMNIBOX_MOTIVATED,

… so on

chrome://predictors/  — chrome estimates the chance that you’re going to a certain url

green – if i type gith, i’m rpobably going to github.org

look at data, lots of interesting

chrome://histograms/ — looked at whitespace, dns_resolution

 could doc.write, stop the world! browser has simple model to verify what’s coming next in the dom tree. stop the world, wait for script to come down and execute, only then will we proceed. this cannot parse until this application.js file has been brought down and executed. the cause of lots of latency, and looking at a blank page while your js is being downloaded.

so the solution is script “async” and “defer” are your only escape clauses. you can say “trust me, i won’t do a doc.write!” but what if not? well if you look at the document parser (“very readable c++ so don’t be scared”) … this if(isWaitingForScripts()) tips us off — if we’re waiting for scripts, let’s start a preload scanner. a preload scanner is optimized to do 1 thing and 1 thing well — get stuff liek stylesheets that could block rendering. technically an image is not a critical resource but we do preload it because it could block rendering. we move ahead in the stream and scan ahead for tehse attributes. it literally just looks for anglebracket img — we don’t want to spend time parsing and throwing away, so it’s simple. 

preload scanner does interesting things — example, this page takes 1.5 seconds. but stylesheet loaded 200ms in, but it came in parallel with the actual html. this is an example of the preload scanner working. i encourage you guys to take a look at some of this code to see what’s going on https://gist.github.com/3058839

not wait until entire page is complete

some lessons learned from this

we have the network stack

the network stack feeds data into the tokenizer, bye

construct dom tree

if dom tree is blocked, the preload scanner is moving ahead and trying to find out what are the blocking resources. this is a fairly efficient way to get your resources scheduled. script execution. while it’s popular to move your dependency management into javascript, in the long run, that’s the worst thing you can do (from the perspective of the browser) cuz you’re moving it away from the browser/hiding it from the browser, so the browser can’t help you. so don’t hide resources from the parser!

you ahve the dom tree, has a lot of stuff we don’t care about in terms of visual respresentation (like meta tags, not on screen) so only stuff that’s visible. then depending on type of element, we’ll have a render layer. some objects get a dedicated layer, like the video tag, which is gpu backed. that by itself has a different tree. 

the moment you need . example: getting width/height/offset – stops the world. 

60fps? for games, right? we’re just building webpages? turns out that’s not the case. if we want our buttery-smooth scrolling on the page, we need 60 fps. at 60fps, we have 16.6 milliseconds budget per frame. so preferably even faster than 10ms just to be safe. in diagram, 1 frame took 46ms to render (“i’m not going to name the offender… ahem mashable” lol) they’re executing some standard banner of javascript that’s taking 20ms or more. these events aren’t accumulated, and sometimes even mlutipel frames per page. sometimes if you’re scrolling nd it’s dragging, this is what happening — javascript executing due to some handler that’s not properly set up. 

we’ve done some testing. one counterintuitive thing i’ve discovered is: better to be consistent than jump all over. it’s much worse to be jumping between 15ms and 60ms (because we can actually percieve that). so instead, pick one

good talk on this from google.io called jangbusters (????) to check out

hardware acceleration 101

sprinkle this on your code and everything will go faster: force a gp layer: webkit-transform:translateZ(0) , all tehse blog posts saying “i put this on all my divs and it goes faster!” so why don’t we

there’s a reason: well, when we do this, we make everything a layer. push it to the gpu. the gotcha: pushing stuff to the gpu is not exactly free. take bitmap. transfer it from cpu to gpu, and that takes a lot of bandwidth. if you take this on your smartphone, could be doing gigabits per second for 60 frames per second, that’ll easily saturate your gpu bus, will destroy your battery.

1. the object is painted to a buffer (texture)

2. texture is uploaded to gpu

3. send cmommands to gpu (apply X to texture Y)

gpu is good at transformations, but then reapplying it back to the thing takes a lot of 

spin animation on hover actually makes sense for pushign to gpu. 

IF YOU ONLY REMEMBER ONE THING…..

(4 gig checkout!)

1st: don’t just drop everything you’re doing and say “i need to understand webkit” — you need to understand it piece by piece. pick something you’re working on right now. go to code.google.com and type in query. code is well-laid-out. htmlLinkElement, 

HTMLDocumentParser, HTMLPreloadScanner (Everybody should read those)

Q: best investment?

A: education. what people don’t realize is that when people come out of the computer engineering degree, we don’t build stuff for the operating system, most of the time we build stuff for the web. there’s a lot of stuff that’s hidden for implemenation. would want to see a lot of change in educational systems. can see classes teaching mapreduce (couldn’t see that 3 years ago). we will get there. in the meantime, it’s up to us to educate. this is the best thing we can invest in. 

Now it’s off to Mighty for Square’s party WOOOO