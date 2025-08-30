---
layout: post
title: "Heather Rivers – Linguistic Potluck – crowdsourcing localization in rails!"
date: 2012-09-14 19:41:23 +0000
categories: ["coding"]
tags: ["conference", "gogaruco12"]
---

I LOVED this talk!!!!!!!!!!!!!

4. Heather Rivers – linguistic optluck – crowdwourcing localization with rails @heatherrivers

Started w/ Ruby at a startup weekend and discovered the true way (cheers lol).

Computer aren’t ready to do natural language processing just yet. Sometimes, we need computers to be able to serve content in different languages. 

token: “{friend} tagged you at {location}.” look simple, but the hardest part of internationalization.

Frank bought a {something} from Dee. articles can be “a” or “an” depending on context. You could solve this by writing a method that detects of the something beings with a vowel, but you’d end up with “an unicorn”. Or you could store , but this is a closed set — you can’t store the right articles anymore. May come to conslusion that you need to have the user enter the article themselves. No need to parse it out. Store id: a unicorn, water, an hour, un croissant, une pamplemousse. 

Store meanings, not words. Otherwise you’ll end up projecting langauges you happen to speak into your schema, ad you’ll be locked into it, which is no good. 

Let your users help you — they know the answers. if you can find a way to extract the answers, you life will be a lot easier. 

Translation is conceptually simple without tokens. take a word, adda  human brain that provides the translation, adn store the ressult.

Add tokens, things get trickier. “{count} books” –> brain –> some representation of rules. We need to find out how to store those rules. Localization is hard. If it were easy, every app would be available in every langauge. Even facebook didn’t start porting its second language until it had well over 50 million users (zuckerburg with redbook, wine, and the bird)

pie chart part – english languages speakers account for only a quarter of total internet users, only just greater than. pie i have eaten, pie i have not yet eaten. 

studies show: when people make deicison in a foreign language, their decisions tend to be less rooted in emotional reactions. So if you make them read it in english and it’s not their native langauge, they may be less likely to fall in love with your app. 

There are ways to do it without changing your application too much. Also you might be worried it’ll cost a lot of money: but not necessarily. There are services that provide it that keep costs manageable. But the other way to do it: crowdsource it and pretty much free. 

Benefits

Forces you to design better software. Keep your content and your code cleanly separated (moses parting the red sea lol). 

How is content transferred to user?

1st you have to store

2. selection: you have to decide which

3. transformation: change the data, prepare it

4. presentation: display in browser

Let’s use Quora for an example. “Question promoted by Dee to 100 people.” Template file: serves as primary storage of text that will be displayed to user, as well as selection , with embedded language-specific transfomration rules , and presentation … all in one file. 

So languages helps you separate this out. benefit of internationalization

storage: yml, database, external service // totally insane humane language idiosyncrasies

selection: locale detection & traslation retreival

transformation: interpolate … (we’ll look at the slides later)

presentation: 

Only the intent is stored in the presentation. 

Another benefit of localization:

A well-placed, widely understood symbol is a better user experience (regardless of how many languages you support). But be careful: apple’s trash can icon, europe thought it was a mailbox. 

Another benefit of localization: flexibility, using different images that support multiple languages.

Another benefit: keep your page layout really flexibile. The size and shape of yoru text can change dramatically, so you end up designing your layout to handle different content more gracefully. 

Be careful about your encodings. Always have a content type and a meta tag, always be careful about your database encodings. 

Else you’ll get mojibake — unreadable characters you get from bad encodings. 

Once you’ve dcided it’s time to expand your linguistic offerings, you need to figure out which languages you’d like to support. Get some tool that helps you gather this info (google analytics)

or rely on http headers (http_accept_language)

LINGUISTICS

– easy to code yourself into a corner if you don’t know the scope of your problem.

– morpheme: smallest chunk of language that has meaning. (the word “cat” contains one morpheme)

the word “cats” contains two morphemes

typical english phrase contains slightly more morphemes than words. (words are conventionally things between spaces)

i saww the cats running away: 6 words, 9 morphemes (saw is 2 morephemes, see and past)

analytic vs synthetic

analytic: chinese, vietnamese, yomba – indicate meaning by word order rather than chagnes to the words themselves.

move across to latin and greek: the ratio changes. a word in one of these languages

one of the most synthetic langauges is inuktitut. if you compare chinese and inuktitut, you’ll get

if you wait for me, i will go with you

ni deng wo, wo jiu gen ni qu: ratio 1:1

inuktitut: 2:9 (two words, 9 morphemes)

Why do we care? a good way to see if there’s word agreement. analytic = no agreement, synthetic = hella agreement

in swahili you have to change every wrod.

japanese exhibits no agreement at all.

so that’s what this specturm is all about.

agreement is kind of a measure of psychomatic complexity. if you change 1 word in 1 part of phrase, it might change other stuff int he phrase.

agreement is very wet: you get teh same things stored all over the place. (write everything twice)

no agreement is dry (don’t repeat yourself) 

let’s talk about the ones that come up the most.

person

gender

number

in indo european languages, person agreement is not that bad

yo soy, nosotros somos, tu eres, vosotros sois, el es, ellos son.

in georgian/hungarian, the verb agrees not just with the subject but also god knows what else in the sentence. hungarian: szeret. verb agrees with both person and number of object, as well as the specifity of the object. (definite vs indefinite — a cat vs that specific cat.)

pluralization rules

english: 1 and not 1. we have it easy. in rails

#config/locales/en.yml

:pets

  :cat

Arabic pluralization rules: lots more categories (zero, one, two, few, many, other)

gender

usually: male/female, male/female/neuter, animate/inanimate. but nto easy because gender is charged issue.

{user} tagged themself in a photo. in 2008 facebook started aggressively asking users to specify gender. in other languages, “themself” didn’t work. decided to ask for missing information, in the name of grammar. be aware of issue: try not to be overly heternormative about it if you end up having to ask for that information because it’s obnoxious. 

now you have an idea of the problem. imlement plan of attack. whatever framework you choose, it’ll be: machine generated, crowdsoured, or professionally translated. maybe some mix of them. 

machine translation: google and a few others offer some client-side translation tools that are not real internatlionalisiontg, but require almost nothing for you. adds this selector to your site, lets you pick from 55 different languages (out of box). from user’s perspective, they have both the original language and another langauge to choose from. and if gogole translate gives them a bad one, user can suggest a better translation. 

storage: database (instead of on google

selection: redirect to local-specific url, pull locale data from storage

transformation: apply stored rules to data

presentation: render result 

rails ships with extensible international

github.com/svenfuchs/rails-i18n

gives you methods like I18n.translate, localize, transliterate

comes with framework for api, simple backend to get you started.

backend, by default, stores your translation in these yml files. produces right ranslation with approriate punctuation. if our localization needs are simple, you can limp by with yml files for a while, but these totally suck for keeping them maintained and synced across langauges so don’t bother.

luckily it’s easy to store these translations in different ways. any persistent key-value store, redis or whatever you want, can chain multiple backends.

or if you have a ton of static content, include locale in your template name (though not good idea, keep logic in template)

i18n-active_record gem stores translations in database with active_record. cached. gem makes caching real easy to set up. super-extensible. translating ui text (or anything else stored in template). 

but if you’re storing text in database (like for a blog), there’s a gem: globalize3. scope activerecord getters and setters to the current locale. easy to use. 

lots of ways to extend this default backend or api however you want. this i18n-inflector gem provides an additional layer of abstraction on the default translation backend. academically faithful, but not practical solution. template really hard to read. but is example of how you can extend the default options. 

yammer uses “tron” (berk/tr8n) to crowdsource translations.

use pirate as an example. click on the current language in the footer, brings up langauge sellector box. click on language, changes all text on page. one day you notice untranslated text, click “start translating” — see red and green lines everywhere, see what has been translated and what hasn’t been. click on red line. if you see a translation that you like or dislike, can vote on it WOW!!!! yammer can monitor translations and translators with admin panel (out of box). 

now, look at case with context rules. click: generate context rules for this translation.

tell tr8n that the translation depends on the numberical value of count.

tr8n is easy to populate with rules. in pirate english, two types of number: 1 and not 1. generates forms for those, lets you fill them in, translation is much better. in backend, all transltaions and rules are stored in pretty normalized way in 

yammer has collected 70,000 translations from 80 languages from users.

lots of advantages to collectnig translations this way:

1. free (kind of)

2. allows for progressive enhancement. you don’t have to wait until every single word of your site is tranlsated before offering a benefit to user (even if at 50%, much better expreience for users). don’t have to wait to populate, people will

3. totally self-monitoring system. requires very little oversight. 

one of tron’s big advantages for developrs: use default lagnauge’s value as translation key.

value: hello name, and second argument “welcome message” .. .also provides disambiguation

lol her coworkers held up 9.9, 9.8 on their laptops at the end =D