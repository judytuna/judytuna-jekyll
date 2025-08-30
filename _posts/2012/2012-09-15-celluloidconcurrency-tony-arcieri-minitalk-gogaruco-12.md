---
layout: post
title: "celluloid/concurrency – Tony Arcieri minitalk – GoGaRuCo ’12"
date: 2012-09-15 21:56:27 +0000
categories: ["coding"]
tags: ["conference", "gogaruco12"]
---

synchronous calls, just like you’re used to in ruby

asynchronous calls:

schedule work to be executed. not sure when. gets excecuted when

instead of bang, use .async, will get bang methods back in celluloid1.0

current thread returns immediately. same countdown will happen.

asynch calls just straight-through. never waiting for results. simple way to schedule work. 

futures

best analogy: call ahead to a restaurant to order food, so hopefully it’s ready when you show up. maybe stil have to wait a few minutes, but better than waiting a long time.

fibonacci!

to get the value back, future.value blocks until it completes.

the messaging model is a bit 

pools

group of actors. schedule work inside of it. call .pool on any class that includes celluloid. includes a class

calculate all those fibonacci numbers in parallel, get all results back. 

beware the gil

contact:

@bascule

@celluloidrb

celluloid.io

blog: unlimitednovelty.com