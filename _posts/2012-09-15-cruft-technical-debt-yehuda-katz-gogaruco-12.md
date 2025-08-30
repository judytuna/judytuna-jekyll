---
layout: post
title: "Cruft & Technical Debt – Yehuda Katz – GoGaRuCo ’12"
date: 2012-09-15 21:47:52 +0000
categories: ["coding"]
tags: ["conference", "gogaruco12"]
---

@wycats, wycats@gmail.com

yesterday, sandi metz’s talk was about how to avoid that cruft. this talk is what to do to fix it! 

the gap bewteen the assumptions you made when you first made the code and years later consumes more and more development time. 

sounds like classic technical debt, but it’s not — you accure technical debt on purpose, and imaging that you will pay it down. 

the problem is like buying a lot of rim stock in 2008 and never

unlike technical debt, technical obsolescence will build up no matter how much you try to avoid it. 

today, examples from open source ecosystem. open source solves problems generically. if there’s a gap, the gap widens quickly.

has given a couple of talks about things behind hard … bit.ly/harder-than-it-looks is a decent 

examples:

jquery: dom readiness. one anchoring assumption stays the same, another is

rails: almost all of rails’s assumptions about security turned out to be wrong.

ember: data bindings, application structures. sometimes will have gaping chasm. 

there are assumptions underlying every decision you make. the constraings under those assumptinos will make you happy today; when those assumptions are no longer true, that’s won eof the main reasons you as a developer becomes less happy about the code that you write. 

this problem is worse with really great solution. with good solutions you can get away with having blah, bland assumptions, so the user is responsbiel for keeping that up to date, so . but i fyou have a really great solution, that takes the burden on itself, changes in assumptions have rapid effects on that gap. if, in rails, html rendering on the server is a bad assumption, then it’s not gonna be siply “no problem, tweak around the edges” — it would be a big problem. or if it turns out clientside dev is not a good idea,then game over for ember, because we took such a big bet. 

side point: a lot of people don’t notice the difference between a partial and a full solution until the

so you end up with checkbox-oriented feature assessments — look at this library, does it have these features? — if you have a project that’s gonna be around for a long time, you have to plan for tech obsolescence. if you do checkbox, you’re not thinking about what assumptions underlie it. 

a big objection to what he’s saying and hpilosphy in gneeral is:… you can avoid software

sandi’s argument is a weak version of this strawman: you can avoid all software problems by writing programs that do 1 thing and 1 thing well. if soemthing changes, remove that piece that viiolates the assumption and replace it with somehting that does,

i think writing good objecte oriented software is going to deal with some of the problems, but this misses the mark. this sort of thinking moves the complexity to a

instead of having a private api (what sandi called the omega mess), you end up with a public unstable mess

no matter how hard we try, these interfaces aren’t perfect. so the idea “don’t make omega messes” ends up with public apis that people using the system have to understand. moves complexity of edgec ases into components. pushes resolving complexity to user. integration tax being placed on user. 

another interesting thing: people

write programs to handle text streams, because that is a universal interface. i’m not saying “ha ha i got you, node is not about text streams, game over” (laughter), there has to be a well-understood public interface in order for the idea of “write 1 thing that does 1 thing well” to work. cuz if you need to spend a lot of time 

complexity

git

when you say text is a universal interface, there’s an assumption that people are using tab or some deliminated output. 

early on in the stage of builing a car (19th century) people didn’t realy know waht a car was yet. so initially, the idea of a vertically integrated supply chain, ended up being effective. won the story early on because there’s the idea of a transaction path (pass?). when you’re not really sure what’s happening in between the pieces of the puzzle, if you do it all yoruself, you don’t have to worry how the parts guy is gonna talk to the assmebly guy.

over time, vertical integration does give way to distributed systems. this happens in economics. happens in response to more standardized way of thinking about htings and mroe supply chains. 

how does this fit in with software?

we understand more about what it means to build a car or web app, know what it means

so a lot of the transaction costs become much cheaper. instead of large transaction costs, eventually it becomes clear (like how you integrate template functions in javascript.)

and integration gets cheaper … only some of the time. if you start off saying “frontload the whole thing! build standards on every link on the chain!” you’re gnona spend a whole bunch of time building standards that don’t end up mattering or really reducing transaction costs, will have become cheaper to not have bothered. 

rack is good example of this lifecycle. giant vertically integrated supply chain. python did it before ruby did it; why, in the beginning of this process, did rails decide not to do that? rails had to choose between “what does it mean ” vs “spend a bunch of time to build a market place of 3rd party components” 

usually small players that realize it’s annoying, as the little guy (sinatra, merb) to build all the connections. there’s a de facto standard. in the beginning, you want to build integrated solutions…

[…]

people respond to cruft in kneejerk fashion. criticism yields defensiveness. over time, in a project, especially as you have personnel turnover, the cruft that’s already there becomes received wisdom — “don’t touch that! it’s probably there for a reason!” 

assumptions change. 

example from jquery. dom node, want to put some data on it. if you put some data on the dom node then remove the node, gc never collects that data. bug in ie =(

proposed solution: put a number on that data. cache it somewhere. when we remove the node, we make sure we remove that data. we take care of it. easy to imagine “o it’s an old ie hack, probably 3 lines of code”…. but sometimes the assumptions you make about your code end up driving a lot of architectural decisions. as long as we support this old version of ie, or old microsoft project, we need this code. that’s where the gap comes from. means you’re gonna build up an immune system… zepto will come up and say “jquery you suck you should mremove that code!” and jquery is like “no if you remove it you’re gonna have a memory leak in ie”

a year ago, jquery did an analysis of the entire code base. they said, we didn’t do a good job of tracking assumptions, but we just analyzed what assumptions we made for old browsers and see . so we were able to determine the cost of removing ie. for a long time, the project had this general feeling / received wisdom that it wasn’t worth it to remove all the ie stuff. turns out it’s true after ie8. 

lifecycle:

cruft = solution

cruft defensiveness

a gap appears

received wisdom consolidation. no matter how large the

splash of cold water (some new person comes into app, or releases competitior, turns out gap has become so wide that there’s some win for reexamining the assumption)

back to cruft=solution….

what’s a better lifecycle?

track your cruft!

in cruft.txt? maybe cruft.markdown? lol

write down a line of code, what the assumption that went into this line of code.

not possible to fully isolate all assumptions, you hvae to ship products, assumptions are real — but you can do this and say “is this assumption stll real?” ember: have recent chagnes in the last few years changed our assumptions? “we have to support old ie” is slowly fading. 

on the flip side of that, it’s okay to be “the dom library for ie6 users”. it’s okay if you decide as a project that it’s a valid assumption for you. 

this whole discussion is not just about the support matrix. lots of inputs go into decisions that you make

what do i want you to do? 

1. i want you to keep track of the edge cases in your code. what the reasons that mght cause technical obsoleence.

2. and how they impact your architecture. think about how much of your architecture is based on these assumptinos.

3. periodically review your assumptions

4. make choices more intentional. document. help contributers make decisions without fear they’re walking on a grate. 

Q: (josh susser) how about the test suite as a place to track cruft?

A: good place, and for every piece of cruft you should have a test, but my point is there should be a place/file where that’s the only job of that file.

Q: wrote a test to make sure the bug was still happening; when it didn’t happen, test would fail and it would tell you

A: good strategy for things like ie6 bugs. less for “microsoft project has this bug, some of our users are affected” … human assumptions, all the contractors still use fax machines. can’t erally write a test about it, but is an assumption. 

Q: overfitting training data in machine learning. deny or connect?: cruft is one-to-one fit to universe at the time. in machine learning,

is that something we could use to help us write code? accept a less perfect solution for a longer-term solution?

A: you can accept that people will not always

it’s not that it’s perfect for some set of data, it is perfect for now. you do want to write code that’s perfect for now. if there’s a tradeoff of perfect for now or pretty good for later, you should take good for later, but a lot of times it’s whether it works at all now 

Q: apple said “no flash on iphones.” when do you make that jump, for example, “no more ie6”? also how do you measure and come out with this data of how big the gap is, so smeone could make their decision for what to no longer support?

A: try not to have the answer never be “don’t touch that.” have the answer be “assumption valid or not”

Q: are you leading by example in this case, say, ember? or any project so we can see this in action?

A: no cruft.txt, but we do have architecture files that talk about why wer’e doing it that way. maybe if i have time. the lesson came from jquery where i saw how much work it was to engineer how to take the cruft out.