---
layout: post
title: "Questions: macports vs homebrew, mac &amp; bash, Rails versions"
date: 2011-09-04 18:23:53 +0000
categories: ["curiosity"]
tags: ["brain dump"]
---

I have http://www.macports.org/ . Are people using Homebrew now instead? 
http://mxcl.github.com/homebrew/
http://www.philwhln.com/homebrew-intro-to-the-mac-os-x-package-installer got rid of macports in favor of homebrew
As for me, I haven't installed homebrew. I'm gonna hang on to my existing macports installation.

The comment at http://www.philwhln.com/homebrew-intro-to-the-mac-os-x-package-installer/comment-page-1#comment-995 says 
sudo chown -R $USER /usr/local 
so i did that so now I don't have to write sudo gem install anymore.

GENERAL MAC QUESTION: My bash profile and PATH variable is all kinds of fucked up. 
http://linux.die.net/man/1/bash says: "When bash is invoked as an interactive login shell, or as a non-interactive shell with the --login option, it first reads and executes commands from the file /etc/profile, if that file exists. After reading that file, it looks for ~/.bash_profile, ~/.bash_login, and ~/.profile, in that order, and reads and executes commands from the first one that exists and is readable. The --noprofile option may be used when the shell is started to inhibit this behavior." I looked at /etc/profile and didn't understand anything there, so that's okay. I looked for ~/.bash_profile, which didn't exist. Neither did ~/.bash_login . But ~/.profile totally existed, and all it had in it were two lines: one from me installing macports, and one from me installing a newer version of python. 

I found: http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
which told me the difference between .bash_profile and .bashrc . More importantly, it told me about the existence of .bashrc. I looked and although I didn't have a .bash_profile, I totally had a .bashrc, and there was one line, obviously added by Tirea Aean's http://forum.learnnavi.org/projects/vrrtepcli-translator/ . It makes an alias for his vrrtepcli program. Now things started to make a little more sense. Obviously, my terminal was never getting to .bashrc (wtf?!) because the vrrtepcli alias had never worked before--after I installed, I could never type vrrtepcli, but I could cd to the place where I knew vrrtepcli was installed and run it as ./vrrtepcli. Anyway now I understand: during the install of vrrtepcli, it added an alias for itself to .bashrc assuming that my bash would call .bashrc … but my bash never calls .bashrc. WTF!!!!!!!!!!!

Anyway so I created a .bash_profile file in my home directory (I remain confused about why I don't have one already or didn't already know about this problem). I followed the advice in http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html and told my .bash_profile to look in .bashrc. Then I copied the stuff I already have in .profile into .bashrc. Now at least I know .bashrc is getting hit eventually.

RUBY: Today I completely fucked up my Ruby on Rails. I'm going to try to describe what I've done.

Last night, I read my OLD railstutorial.org pdf, version 2.3.8 of the book. That version is from last year and uses Rails 2, and was released by the author for free because he was still writing it or something. I'm using an old version of Ruby and an old version of Rails to go along with the book. I don't remember what version of Rails I had, only that it was before 3. Everything was fine until I got to the part about installing a plugin for gravatar. I installed the gravatar plugin using 
$ script/plugin install svn://rubyforge.org/var/svn/gravatarplugin/plugins/gravatar
which put the gravatar plugin into my project's vendor/plugins folder. My tutorial said that now I should just be able to use the gravatar_for method in a .erb file, but my tests were all failing: it didn't know that the gravatar_for method existed. When I fired up script/console, it knew that GravatarHelper was a Module (cuz I typed GravatarHelper.class in the console and got Module), but it didn't know about gravatar_for, which is a method in "module PublicMethods" in my app's vendor/plugins/gravatar/lib/gravatar.rb. Soooooooooo I didn't know what to do, so I tried updating the gem. Then I did gem --update system, because I read about that somewhere (on the rubygems website probably). Then I did gem --update. 

Why on earth would I do such a thing? I knew that I was using an old Rails, and I was using an old Rails on purpose, so that I could use my old tutorial. I was vageuly aware that Rails 3 is different. Anyway I thought that somehow the gem --update tool would know that I was using an old rails and only update my gems up to that version of Rails. Obviously I forgot that rails is itself installed as a gem. Sooooo it upgraded my Rails (and everything else).

Right now, when I type ruby -v, I get 
ruby 1.8.7 (2009-06-12 patchlevel 174) [universal-darwin10.0]

When I type rails -v, I get
Rails 3.1.0

Oops. 

So the project I started (and got halfway through) last night doesn't work at all anymore D: and I don't know how to roll everything back easily. 

I guess I'll start the tutorial (and my website project) over. The railstutorial.org book for rails 3 is available on the website, which just means that I'll have to work on it with an internet connection, which is okay. 

Also I'm going to try to learn to use rvm http://beginrescueend.com/basics/ , which I found out about from Robert, the teacher for the Ruby class at the SF Public Library on Tuesdays. 

Gaaahhhhh