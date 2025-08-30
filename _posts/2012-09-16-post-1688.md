---
layout: post
title: "MonoRail: Monolithic Rails Application – Jack Danger – GoGaRuCo ’12"
date: 2012-09-16 01:04:21 +0000
categories: ["coding"]
tags: ["conference", "gogaruco12"]
---

MonoRail:

@jackdanger from Square, Inc

1. rails applications go in a particular direction and you

2. problems primarily about ownership.

imagine you have not a monorail, but a green fields applications, you got featured on techcrunch, everything’s great.

fast forward 3 years in the future. you have a rails

several $30,000 mysql box.

over 1,000 controllers. but a lot of rails apps now are well in excess of that and who knows how many

spotty test coverage. no idea how much because rcov would take 7 years or segfault

sad developers. 22 devs talking about how they don’t want to walk on a big company anymore (cuz you have 30 employees) and they want to work on something where they can make a difference (laughs)

ultra-slow test suite

you might think, you can avoid this, this won’t happen to you. twitter, square, groupon, yellowpages, livingsocial, modcloth — all of these and more survived a monorail. they’ve pulled pieces of rails 2 code on 1.8.2 out and onto services that are manageable.

but look at the first day

“can rails scale?” is not a question. heroku ps up, tada, you’ve scaled rails (lol)

real questions: scaling your data, codebase, customers, feature count

codebase: git and github fixes this.

customers: communications, engaging with customers, and logging (so you can explain what happened

feature count: rails is actually great at this. you want a new feature? new path, new controller action, new database table, bam. 

what we don’t talk about is scaling your developer headcount. there’s no pattern or tool that helps us do this. 

in the beginning. this is you, on day one, with a green-field project. 1 app == 1 product == 1 developer. welcome aboard, put your code here — the one place your code is. twice the pace because you have 2 people! great pattern for early days.

want an admin interface? add /admin ! how about analytics? put /trends ! (though let’s get real — you’ll just put it into your view in the admin interface)

“rails can do anything!” “let’s make it do everything!”

this is the reason we get monorails is because let’s keep going this direction! little by little.

you can subclass actionmailer because you’re doing it only once. not good software design, but it works.

add email, phone, etc… validates_presence_of all of them… so easy to just add a set of methods inside of user.rb but it’s all right there, easiest way to get your feature out the door, testing if product should exist, this is where to put it. 

nice mini-framework. throw that in ./lib ! also tests in ./spec/lib !”

problem: rails is optimized towards the beginning of the experience. (postgres great for most things lol). 

examples of directions rails could go from the beginning. if you’ve worked on giant enterprise problems, they’d pick the “mature” side, but 

young: 1 database. mature: many databases.

even in a single

select records from 1 table, grab those ids, go to another table with the ids in the query, grab records, does 3rd query, then present them to you . eager loading multiple queries. if you’re hitting multiple times anyway, why not look up user’s locations in riak or something? just can’t 

young: MySQL or Postgres at 10,000 = you’re fine. but mature: postgres does things really well. postgres does not need to do an entire table copy and rewrite to change a default (mysql you would)

young: ActionMailer. mature: anything else. you should have an actionmailer project (on sinatra or something) and a rails project that tries to send mail. you have two application.html templates, one is for web, one is for email. those should be different jobs. done in a different project where they can do their own deploys (like for a copy change, they won’t have to deploy your 

young: lots of data in ‘users’. mature: only authentication in ‘users’ table. that’s it! anything else is a feature that relates to that user. if you grow infinitely, it will be in a different 

young: features sitting in ./lib. mature: internal gems. if in lib, needs to be extracted and put into a private gem. nothing should be there for more than 10 days or so. (and if you have object_patch.rb, just delete that)

young: validates_*_of. mature: database validations, else you’ll have corrupt data. you’ll have sad users. 

young: default logging. rails will log what it does, but your app should log what it does too. mature: log every significant action. 

young: analyze your data … in the main db. have sql do multi table joins, time series. problem: that data is in the wrong shape (in online transactional processing instead of by day), also interfering with . mature: analyze your data elsewhere. ETL – extract, transform, and load. (xavier) set up stuff with replicas, and star schemas (?), group things by interesting trends.

story: hitting reload took us down. “i would call this a weak point in your application”… fixed!

conway’s law.

the shape of your people shapes your app. 

deterministic: if you put in the work, you have control. problem comes in when you have other people working on unrelated things, you could have a situation where your thing is great but doesn’t work. so instead, have each person or team work on a specific different thing. how to do this? 

rails can do this, but it’ll take foresight. 

companies that have a monorail: it starts when you decide to have teams

1. service interfaces. you need to build internal apis. not for everything, but for all the things that you think maybe someday shouldn’t live here anymore. like email. give bare minimum information about what you need for this task, with nothing about how it needs to be done. some team will say “we’ll take the other side of this service and fix it.” nothing you do will ever change this. no longer your concern because there’s a line between your responsibility and not your responsbility. 

another example that’s made-up: marketing front pages (a signed-out experience), a signed-in experience using html, and an api. clear definitions of different sites, but all in same rails.

Marketing.render request, :with_condition => “public”

something can happen inside of there, it’s an omega mess, but its’ someone else’s responsbility. 

2. extract the code

copy the app via git clone and delete the parts you don’t need on the other app, or you can rebuild the piece that you want from scratch. will have to modify a lot of files to do stuff like this. but you should be deleting or moving or adding files, not just modifying files. 

3. move the data

across the databases. everybody’s got an interesting solution. 

most important thing: recognize there’s a real human cost for not recogniz

as soon as we change our group structure, we’ll be in trouble. instead of building things we imagine, we’ll be maintaining someone else’s code.

we deserve to go into work every day and be happy.

ruby was optimized for happiness by matz, rails opt for happiness by dhh, mega rails not doing a good job of making us very happy.