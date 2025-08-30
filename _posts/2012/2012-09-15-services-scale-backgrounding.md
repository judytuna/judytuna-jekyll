---
layout: post
title: "Services, scale, backgrounding – David Copeland – GoGaRuCo ’12"
date: 2012-09-15 18:44:15 +0000
categories: ["coding"]
tags: ["conference", "gogaruco12"]
---

David Copeland, http://www.twitter.com/davetron5000

Based on his personal experience at LivingSocial, building Payments app. Story of rasonable programmers making reasonable decisions leading to WTF

Resque – creating a job that will be serviced by the NewPersonEvent class, given id when run, jam into redis (which is superfast key value store). So this will be fast, way faster than regular mail call.

Resque poller will find this class, will call perform, finds person in database and sends welcome email.

Now we can allocate things for usres to make , manage background process separately (even on a different machine). This is good, ability to scale under certain conditions, all good. 

A few months later, we get an email about smoething that went wrong. This line of code inside our person controller (in ‘create’) generated a timeout. Resque.enqueue(NewPersonEvent

Tmeout to Redis

4 good things all came together to create a weird situation

1. signs up

2. doesn’t make it to redis, doesn’t get welcome meail

3. user tries to sign up again

4. can’t because of email uniqueness

Solution

1. person created and email sent

OR

2. no email sent and no person created. then we don’t have to go into console and fix it.

— So we will use database transactions to fix this. 

Go back into controller. Person, activerecord, has transaction. If the resque fails, the user is never created; they still have to deal with a 500 error and sign up again. If we keep getting these timeouts, then we still have a problem, but at least it’s better. 

A few weeks later, we get an exception in our job processing class.

In reque, when a job goes wrong, it goes into a fail queue so you can replay them. A transient error (like a teimout or network failure), you can replay that. This is not a transient error, it seems: person id not found in the database. But… wtf, we GOT the ID from the database? what could cause this? 

1. got id from the database

2. event created. the second we create this event

3. event processed

4. BUT the transaction is not yet committed. the ability to roll it back is possible because no one outside of us can see what’s happening in the database. race condition. “and i see this all the time.” we can solve this by not using resque, who knows what other problems? other way to fix this? 

could assume that if we get this sort of error (person not in database when this code fires) then it’s some sort of race condition. so we can assume that

ResqueRetryOTron7000 (assume we have something that does this for us)

have a condition that we expect might not be met at the time this is processed. if it’s not ready, try it again a fixed number of times so we don’t go into some infinite of

not amazingly clean beuatiful code but it does work and wasn’t that hard to complete. 

better(ish)…

likely to complete in 5 retries

can replay any that bubble up (if this doesn’t solve something)

no grand rearchitecture required

our company: we’re so successful, we’re gonna buy our competitor.

we need to get their users into our database. our comptetittor didn’t have email validation.

we want same buisnes logic to happen as if they signed up on the website, but they’re not signing up–w e’re being given

another way to say it is: 

after_create hook

every time a new person is created, do the new person

:after_create :new_person_event

controller code actually improves the codebase, is cleaner, which is rare (a new requirement actually cleanig up your code)

activerecord callbacks… maybe you don’t use them, but it’s hard to argue that it’s not terrible. it seems logical. 

a few months later, we need to log stats.

1 method, 1 line, in send_new_person_event, add a log. Stats.ping(:new_person)

weeks later, need cache. add that in too. PersonCache.put(:name,@person.id,@person.name)

skunkworks project.. weird bayseian network… they have to add hteir lines of code in there as well.

…..

now you have a whole bunch of things ending up in our poor abused send_new_person_event. 

Is this reasonable?

– it looks like a mess now

– but each line was _reasonable_ …

– that’s the definition of technical debt. we as a business were willing to accept this crappy looking method because we got business value more quickly. maybe someday we’ll fix it. 

meantime… (parallelism in a company is just as crazy as in a computer) we were working on mailers. we decided we didn’t like them. migrating our old apps to use a new awesome mail service. they made it a simple REST call. “this is gonna be an easy migration” 

so we go into NewPersonEvent. now we use MailerService.mail(:send_welcome_email,person)

if you’ve ever done this, you know it’s not this simple.. 

Meanwhile….. someone else is refactoring send_new_person_event. their solution is removing all those weird lines. they put it into the event itself. it’s running in an offline process where we dont’ care about if it takes longer to run. now we don’t have to mock those all out when we run our person tests. it seems logical that stuff about making a new person is in the new person event. sounds reasonable. 

so we use the new mailer service, took care of technical debt, think everything’s good…. then an event fails. 

1. mailerservice.mail(:send_welcome_email,person)

2. stats.ping

3. personcache.put

4. died. half-played… some of it has gone through, some of it has not; could fix in console but this is not good. we could wait for this line and hten do the next line, etc, but there’s a reason we’re not using node (chuckles…)

why does he think this is happening? mailservice is dumb. what would have made it smarter?

– idempotent calls (only sends 1 mail to the user, even if you call it again). how’s it gonna know which ones to send and which ones not to?

– additional calls to expose state 

for making it idempotent (the way we’d implement the mail service not having to keep track)

– require a client-generated request id

– promise to only perform operation once per request id

so, can call mail a zilllion times, only one mail sent ever, same result goes back. 

if the mail service instead couldn’t do that, but wanted to expose its internal state to us, could have done

– what emails have been sent?

-client checks first before sending.

not as good, but would have worked. 

other changes were small, could have done within app. but this is changing the mail service, now we have a 3month old app going into version 2, sad. 

what if

– mail fails at the gateway?

– i forget to check first?

– two request come in at the same time?

– my request ids clash?

jackie chan out of your mind! lol

So. The bad news is that you’re never gonna get it fixed. you can’t make it perfect. can’t prevent every weird thing frm happening. what you can do is get a better sense of what might happen so you can evaluate how to fixt hem. 

ok, some strategies. 

I. Historical record

1. have a historical record of what happened. log log log. rails is good at logging waht it’s doing, but you need to log your business information. what info would you loved to have a wrong. if it’s feeling expensive, do a debug and take debug out for production, but you want this.

2. audit activity. figure out who changed that, what did they change, when, maybe even why.

these two things together can help you piece together wha thappened at some point in your app’s history. often not order you think it’s gonna be. 

II. prevent bad data

– AR validations canont be trusted. can’t rely on this only. you have to have this for usability. you know the database is gonna keep things in order.

– database constraints are very simplistic (mysql doesn’t have sophisiticated checks you can run)

– sanity check the rest (email someone if it finds something. run this in cron all the time. when it comes back with something, fix it instead of coding around it, will pay off down the road. make code have as few stupid complexities as possible)

III. fix errors

– email your team. “we gotta stop what we’re going and fix this problem right now. app has a bug, preventing user from doing something that’s iportant to business.”

– fix the problem or prevent the error

– downgrade to warnings as needed (so as not to fil your email inbox with unactionable items)

IV. extract services

– don’t just ‘be dum’

– design for idempotence – there’s a lot of complexity about preventing bad things from happening.

– provide help for client (so client knows what’s going on, can do a bit of selfhealing maybe)

i have really enjoyed solving these wacky problems, and livingsocial is hiring

i wrote this book that has nothing to do with this talk but i would love if you bought a copy of it (lol) http://pragprog.com/book/dccar/build-awesome-command-line-applications-in-ruby