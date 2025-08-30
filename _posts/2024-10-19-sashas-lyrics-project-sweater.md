---
layout: post
title: "sasha's lyrics project, \"sweater\""
date: 2024-10-19 01:50:39 +0000
categories: ["coding", "life"]
tags: ["death"]
---

update: got it working [https://bit.ly/sweater-by-tastycode](https://bit.ly/sweater-by-tastycode)

I recently learned that Sasha died last week. I don't have words. I'm really sad. 

I scrolled through her facebook all the way back to 2020 to find a link to sweater, a ruby app she made that replaces words in lyrics with other, rhyming, words. The Heroku project she had it on is no longer active. So I'm going to try to put it back up. Here is what I am doing.

1. Forked tastycode/sweater to judytuna/sweater on github https://github.com/judytuna/sweater 

2. Reset Heroku password lol

3. Add a credit card to Heroku. Looks like there's no free tier at all anymore and now it's a $5 "eco" tier for the same thing (pooled resources that turn off when you're not using them). 

3a. My credit card got this error "Error The provided PaymentMethod was previously used with a PaymentIntent without Customer attachment, shared with a connected account without Customer attachment, or was detached from a Customer. It may not be used again. To use a PaymentMethod multiple times, you must attach it to a Customer first." lol 

3b. Ok a different card worked. Subscribed to Eco.

4. Created new Heroku app "sweater"

5. Connected Heroku to Github and selected judytuna/sweater

6. I hit the Deploy button

dammit it didn't work

`

       An error occurred while installing nokogiri (1.10.10), and Bundler cannot

       continue.
       In Gemfile:

         nokogiri
 !

 !     Failed to install gems via Bundler.

 !

 !     Push rejected, failed to compile Ruby app.

 !     Push failed

`

Uhhh is nokogiri 1.10.10 super out of date lol

8. add my public key to github lol, all of mine expired i guess

9. clone sweater project on my mac

10. hahahaha rvm is here and lo and behold i have ruby version 2.7.0 on here already

11. rvm gemset create sweater

12. rvm use 2.7.0@sweater

13. bundle i

14. bundle exec ruby server.rb = 3.0,  mysql

Upgrading from MySQL 9.0 requires running MySQL 8.4 first:

 - brew services stop mysql

 - brew install mysql@8.4

 - brew services start mysql@8.4

 - brew services stop mysql@8.4

 - brew services start mysql`

46. ok did that... now running rvm install 3.3.5 cuz that's the latest, and Heroku supports it

47. `ruby-3.3.5 - #compiling - please wait

Error running '__rvm_make -j4',

please read /Users/judytuna/.rvm/log/1729313256_ruby-3.3.5/make.log

There has been an error while running make. Halting the installation.`

ok... searching gets me https://github.com/rvm/rvm/issues/5254#issuecomment-1801500921 so i tried `rvm install ruby-3.2.1 -C --with-openssl-dir=/usr/local/etc/openssl@3` but with 3.3.5. (first i ls /usr/local/etc/openssl@ and saw that 3 existed)

48. it's 21:57 now. the #configuring step takes a long long time.

`judytuna@ikran19 sweater % bundle update

Could not load OpenSSL.

You must recompile Ruby with OpenSSL support.`

oh god

49. trying `rvm reinstall ruby-3.3.5 -C --with-open-ssl-dir=/usr/local/bin/openssl`

got

`ruby-3.3.5 - #compiling - please wait

Error running '__rvm_make -j4',

please read /Users/judytuna/.rvm/log/1729314684_ruby-3.3.5/make.log

` again. so i'm trying https://github.com/rvm/rvm/issues/5254#issuecomment-1849289243 , which seems kinda bad cuz it's gonna use ssl 1.1? is that bad actually?

`brew uninstall gnupg gnutls libevent unbound wget

Error: Refusing to uninstall /usr/local/Cellar/libevent/2.1.12_1, /usr/local/Cellar/unbound/1.22.0 and /usr/local/Cellar/gnutls/3.8.4

because they are required by lima and qemu, which are currently installed.

You can override this and force removal with:

  brew uninstall --ignore-dependencies gnupg gnutls libevent unbound wget

judytuna@ikran19 sweater % brew uninstall gnupg gnutls libevent unbound wget lima qemu`

but then i decided to try https://github.com/rvm/rvm/issues/5254#issuecomment-1849289243 instead so

`brew install openssl@1.1  # May say “already installed and up-to-date”, which is just fine

rvm install 3.1.4 --with-openssl-dir="$(brew --prefix openssl@1.1)"`

*** note to self: later you must run brew install gnupg gnutls libevent unbound wget lima qemu

OKAY IT WORKS

I AM TIRED SO I AM JUST GONNA PRESS SAVE ON THIS POST

![](https://judytuna.com/wp-content/uploads/2024/10/Screenshot-2024-10-18-at-23.05.38.png)

[https://bit.ly/sweater-by-tastycode](https://bit.ly/sweater-by-tastycode)