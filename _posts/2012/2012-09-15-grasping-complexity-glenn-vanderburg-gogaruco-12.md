---
layout: post
title: "Grasping Complexity - Glenn Vanderburg - GoGaRuCo '12"
date: 2012-09-15 23:19:24 +0000
categories: ["coding"]
tags: ["conference", "gogaruco12"]
---

livingSocial
@glv

As programmers, we love simplicity. 
harder to write/design, but pays off in the end. 

Our world is binary. 
because of the things we do. answers are true or false, right or wrong, the solution works or is broken. these are concepts we work with in code. that's a good thing. but it carries over to other parts of our work. dealing with vague things is unsettling. 

complete solutions. 
we want to cover every edge case, complete solution. holy grail is both simple and complete. handles special cases without special 
daniela told us a mathemetician's joke yesterday, so today i'll tell you a programmer's joke. 
zoologist says "omg a spotted zebra! no one else has disco
physicist says "hold on. at this point, all we know is that only one zebra
mathemetician says "sloppy thinkers. all this tells us is at least one side 
programmer is saying "oh no. a special case!" 

lol!
when i first heard that joke, thought it was programmers who aren't very good. should be: "aha! spots are generalizations of stripes." this turns out to be true. if you're writing a shader, you can tweak it to make spots like a cheetah, or a tiger, or even stripes like a zebra. lol. 

we like challenges. that's why we like scala (lol) and obfuscated coding contests. we had one of these in living social. 
here's my solution: a yml parser that only uses regular expressions. haha. we like complexity sometimes. 

but we don't like complexity when it seems that the complexity has no bounds to it. there's no way of knowing or pinning down all the little concepts we have to take care of.
sometimes, even the best solutions we can think of have downsides. we tend to recoil from these complex problems. if we are not able to completely run away and just ignore them, often, unfortunately, we pretend. we oversimplify, we act as if the problem were simple. 
a motivation for where talk comes from... it's election year. in our sound-byte and anger-driving political culture, we oversimplify. 

will talk about: the ways we oversimplify, and jump to decisions (and make poor decisions) because we don't face the full complexity of the problem ahead of us. then talk about some techniques/habits of mind we can cultivate to have us not recoil from complex problems, reach more sane solution for compromise in the face of complex problems we face as programmers. 

one way we oversimplify: 
we concentrate on primary effects, and ignore second-order effects. 
story: business partners, one was top patent holder at dell. made process of getting patents through streamlined and cheaper, thought, we can build a . at first, thought: the world doesn't need more patents. second pushback: it's not a mechanical process, it's a human process -- the patent office is comprised of human officers; if there's a product that funnels more patents into the process, they'l change the process. that's an example of ignoring second-order effects and assuming the system you're trying to change is not going to push back on you. 

other way we oversimplify: forgetting secondary benefits. 
when people teach tdd, they focus on the one benefit that's the most interesting. if you only choose one benefit, it's not a slam dunk... you have to remember all of them put together for a slam dunk. "wel there's cheaper ways to catch errors" -- but what about the other benefits? 

asking the wrong question
sandi, in her talk yesterday, had a great example: pepole ask, what object should know this? perilous question because it assumes that one of the objects should. the answer "well, one that hasn't been written yet" is not likely to occur to us. so instead, ask the question "what message should i send?" then write the code that way, and it might be clear that you need to write a new class to send that message. 
story: why would the ops team do this? turns out th
story: why isn't programming more like engineering? may be the wrong question. ask, which kind of engineering is it like?

binary thinking. 
fall prey to the "sucks!" "rocks!" dichotomy. 
story: yehuda: "v8 has a bug" - sometimes people dismiss things as soon as we find a flaw. 
daniela touched on this: some say tdd doesn't prove your app is perfect, but that doesn't mean don't use it

taking rhetoric at face value.
12 rules of xp, "you have to do all of them or you can't call it that!" -- but maybe you could take a few concepts and apply them and get a benefit. 

ignore context. 

giving up. 
"some people are just good designers" -- it's magic.
"he just doesn't get it." what that tells me is: you haven't taken the time to understand his objections. 
"it just feels wrong" or "so beautiful and elegant" -- what do those things mean?

what i'm trying to say is: there are useful techniques for grasping complexity, even when we have low-quality evidence for our solutions. 

incomplete solutions
we should learn to seek these. 
story: businessman who has built career out of tackling problems his engineers . 80% solution for 20% of the effort. 3 simple rules. for weight loss: never eat white foods. never eat in front of the tv. always park in the most distant parking space. these rules are not optimal. might not be the fastest way to lose weight. cauliflower is not bad for you at all. but keeping the rules simple means that people can remember them and stick to them; works with the way people think. seek heuristic or probabilistic solutions. heuristic reasoning used to get to approximate answer. 
another example: git depends on a sha has for a bit of text. we KNOW that there CAN be mlutiple pieces of text with the same sha. it's just so unlikely that it's worth trusting that it won't happen. has called github a globally distributed attack on sha1. (laughter) a precursor of that, the first thing i encountered of "yeah bad things can happen but we hope they won't happen" - network file server in plan9 called venti. block-addressable file server, list of block addresses. the block address was the sha of its content. a lot of files change is small ways, so tomorrow's version of the file might share all the same blocks instead of one at the end of the file. could have different versions. "the infinite improbability disk drive" haha
so we should think about how much liklihood of failure we can accept. 

exploit power law distributions. 
basic statistics:  normal distributions, bell curves; doesn't give us a lot to work with. 

think in terms of costs and benefits
also think in terms of future costs/risks. even applies in things like preventing terrorist attacks. recoil if we put a dollar value on human life. but there is a limit of what we want to spend on that. can't say "whatever it takes." 

exploit emergent phenomena

seek the root of intuition
steven's talk: experts forgot what they learned. 

study "wicked problems"
rittel and webber, "dilemmas n..."
then also, someone else wrote a series of blog posts on wicked problems
they have no stopping roles. solutions are "made the problem better or worse", not true/false. no immediate test. one-shots. almost all wicked problems can be described as the symptom of another problem. 
economics, epidemiology, spend some time looking at the techniques people have come up for wicked problems.

seek simplicity: don't overcomplicate. but when faced with real complexity, grasp it: don't oversimplify.