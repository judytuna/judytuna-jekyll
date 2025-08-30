---
layout: post
title: "Schemas for the Real World – Carina Zona – GoGaRuCo ’12"
date: 2012-09-15 19:31:23 +0000
categories: ["coding"]
tags: ["conference", "gogaruco12"]
---

developer and sex educator, think a lot about how these things overlap (xkcd about ‘sex’ not being found on fitocracy lol)

imagine everyone thinking that who you are and who you love is wrong. then imagine that everyone on the web doesn’t let you say who you are. excluded.

canonical set of relationship statuses?

3 years ago – facebook figured this was a pretty good model, and arguably

single, in a relationship, engaged, married, it’s complicated, open relationhip

separated, divorced, civil union, domestic partnership

g+ left out separated and divorced, and added ‘i don’t want to say’

allowing users to identify

driven by people rejecting a user experience that wasn’t driven by them.

not about monetizing — not providing 

3 problems

1. the perception

2. the assumption that canonical lists for tehse things do and must exist

3. our faith that the first 2 problems can be solved by adding more list items. this isn’t gonna 

so you end up with having to choose “in an open relationship with 1 person”

this is facebook failing to model relationships in a relational database. user has to choose between following along with the database or being truthful. 

sam hughs – modern relationsal schema for marriage.

realized that relational databases just couldn’t model real life complexity. a graph database is needed. 

how do we bring modern realities into the data, views, logic?

we can build a foundation for sane development and ux. 

I. get schemas into alignment

1. mental schema

– set of preconcieved ideas

– framework for represeintg some aspect of the world

2. Database schemas

– mental schema translated into blueprint for database 

when you use rails generate model or scaffold, it’s creating a migration. they ge ttranslated into unified schema to use in your database. 

all this ux is just manifestations of mental schemas. our schemas and ux are leaving people behind, and we can fix it. 

start with the question: what benefit will the user notice? this is NOT the same question as what will benefit the user, because the answer is ‘an awesome product, that will benefit them!”

1st: it’s shitty to be told “you are wrong about who you are” 

MetaFilter – initially, developers said “dirty data is terrible” but then it was quickly embraced, hilarious posts (gender bender bo bender lol). says something about you, and what MetaFilter was used for. users asked, can we please share more? today, there are many freeform field, including ones where developers woudl instinctually validate. so values can be silly, nonsensical, even contradictory, — express yourself however you want to, we developers can handle it. 

data doesn’t have to be for analysis. 

diaspora* !!! sarah mei turned gender into a text field too! the users had fun.

some developers were not amused – effect on internationalization of gendered pronouns. gendered pronouns are a rat hole. so internationalization build on gender is bad. if you MUST, then ask the user what proouns you prefer. munroe (xkcd) says this. this matrix looks crazy, but better than others. (if you insist, there are some gems to check out — i refuse to RECOMMEND them, but here they are: SexMachine gem tries to predict male/female based on name and country LOL. dunno if there’s any amount of wrong in a gem that’s okay. other gem: I18n inflector gem, will fail)

as developers, we have this vision about what a good codebase should and should not be. we want structured, orderly, predictable. so we love stuff like relational, index, grabbable and sortable. make lists that are neat and exhaustive. we want clean easy analytics, so we can make decisions. but what we get when we try to do this with personal identity data is … tons of code. validations of what humans are like, then throw exceptions because they’re not. deal with conditionals and partials for meeting these conditions. 

there is middle ground: a guided response comes in: autosuggest.

if necessary for structure, can try minimal suggest. for example, for gender, could suggest first 2 you think are most interesting, or first 7, or whatever, but if they start typing something different, then it becomes totally free form. 

once they’re free to opt out of providing their personal information, of course they do. but the data quality will improve when users can choose waht they share. proven by metafilter’s experience. 40% of mefi’s users do use f, m, female, male.

facebook makes relationship status optinoal, but it’s coercive for people who do opt-in. most users do opt-in — 60% of them select some relationship status. 

bottom line: we want users to feel passionate about their involvement of what we built.

analytics, in

the data being collected by coercive approaches: the danger is that it’s all bullshit, because it’s lying. conclusions drawn from coercive approaches may be fueling our decisions and it may all be wrong! 

t.string “gender”

is how to solve that. make this stuff flexible up front. optimize for storage. decide what’s valid later. so that’s a discretionary field. optional, 

t.string “relationship_status”, :null => true

documenting a product decision, a promise to your future self

takeaways

1. modeling the world is complex, that’s ok

2. assuming we know who users are surrenders opportunity to learn who they are!!!! this is innovation

Q: advertisers? what if they want

A: metafilter is financed by google ads. since there is no gender information (and mefi doesn’t run gender analysis), clearly google advertising doesn’t care that much, so it’s not an issue. you have the potential to learn who else is in this audience, you can start to address niches. 

Q: not to diminish people who don’t fall into categories, but say for the case of a checkbox vs a text field, would you say that it’s a worse user experience for most people to have a text field rather than a checkbox or radio box? at that point, is it worth it for doing that?

A: all tradeoffs that have to be out of your user set’s needs, adn your app’s needs, you have to know what everyone tolerates. no way to make everyone happy, you will get people polarized over it. the earlier you do it, the less polarizing it is. mefi did it early, and h. diaspora wnet from a select to a text field so they 

Q: you seem to be advocating this for all demographic data.

A: personal identi

Q: there seem to be some legal requirements. is personal identity data not part of the

A: 

Q: i’ve worked with the dating space. a lot of users are gender normative and expecting that for matching. if you do open it up to a text field, how do you deal with gender-seeking? for 90% of the users expecting gender-normative answers.

A: auto-suggest. and the people who are not gender-normative are going to be excited to look for people who are more like them. wildcard search. spit out list of what other values are to use as tags for people to do some surfing around 

Q: (sarah mei) hi. so i’m the programmer that made the change in diaspora. what i can tel you from our users: even people who do fall into gender-normative categories feel better about

a lot of people who identify with gender normative categories told me . “ada lovelace” as her gender. when you do this, you’re not reducing anybody’s user experience. you’re enriching everybody’s gender experience.