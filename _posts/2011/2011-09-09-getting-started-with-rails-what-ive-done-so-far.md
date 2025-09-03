---
layout: post
title: "Getting started with Rails - what I've done so far"
date: 2011-09-09 20:04:41 +0000
categories: ["curiosity"]
tags: ["brain dump"]
---

Five days ago, I restarted the hartl [Rails tutorial book](http://railstutorial.org) so that I could do it in Rails 3.0.9. These are my notes: I took them so that when I try to make my next project, I can find information more quickly! They grew much bigger than I meant. Doesn't wordpress have a "read more -->" button? Follow the jump for the braindump! =D

9/4: I'll try to keep track of the tools I'm installing. 

rvm: http://beginrescueend.com/
Through rvm, I installed a newer version of Ruby by typing rvm 1.9.2
They also talk about rvm on the "installing ruby" page: http://www.ruby-lang.org/en/downloads/

[I'm keeping this in roughly chronological order. As an aside…
ImageMagick: http://www.imagemagick.org/script/binary-releases.php#macosx because Paperclip needs it. Already installed ImageMagic (as of 2pm on 9/4/11)
Haven't installed https://github.com/thoughtbot/paperclip yet though, waiting to figure out hw to use rvm gemsets (at http://beginrescueend.com/gemsets/basics/ )
Some guy talking about ImageMagick and Homebrew http://weblogs.manas.com.ar/mverzilli/2010/05/19/install-the-rmagick-gem-in-the-painless-way-with-homebrewinstall-the-rmagick-gem-in-the-painless-way-with-homebrewinstall-the-rmagick-gem-in-the-painless-way-with-homebrewinstall-the-rmagick-gem-in/
=( I'm only including that for future reference -- I've not installed homebrew.

http://wiki.sourcemage.org/Git_Guide for using Git
Aside is over]

Okay, so ruby 1.9.2 is now installed through rvm. I then set rvm's default ruby to 1.9.2 using http://beginrescueend.com/rubies/default/

Now I'm looking at http://beginrescueend.com/gemsets/basics/
I discovered that I have no gems in my new 1.9.2 (well in particular, no Rails). I am deciding if I should make a new gemset called rails310 and THEN install rails only to @rails310 … 

I made a ~/.gemrc file and disabled rdoc and ri for gem installs and updates. (2:20pm)

$ rvm gemset create rails310
$ rvm 1.9.2@rails310 (to put me into the @rails310 gemset)
$ gem install rails (i didn't know what version number to put so i just tried lol… gave me Rails 3.1.0)

then I read more of http://ruby.railstutorial.org/ruby-on-rails-tutorial-book#sec:rubygems and found that the author talks about rvm, and that the tutorial book actually uses rails 3.0.9. so…

$ rvm --create use 1.9.2@rails309
$ rails --version (just to verify that there is no Rails in @rails309, YAY)
$ rvm --default use 1.9.2@rails309
Using /Users/judytuna/.rvm/gems/ruby-1.9.2-p290 with gemset rails309

judymbp:~ judytuna$ rvm info

ruby-1.9.2-p290@rails309:

  system:
    uname:       "Darwin judymbp.local 10.8.0 Darwin Kernel Version 10.8.0: Tue Jun  7 16:33:36 PDT 2011; root:xnu-1504.15.3~1/RELEASE_I386 i386"
    bash:        "/bin/bash => GNU bash, version 3.2.48(1)-release (x86_64-apple-darwin10.0)"
    zsh:         "/bin/zsh => zsh 4.3.9 (i386-apple-darwin10.0)"

  rvm:
    version:      "rvm 1.8.1 by Wayne E. Seguin (wayneeseguin@gmail.com) [https://rvm.beginrescueend.com/]"

  ruby:
    interpreter:  "ruby"
    version:      "1.9.2p290"
    date:         "2011-07-09"
    platform:     "x86_64-darwin10.8.0"
    patchlevel:   "2011-07-09 revision 32553"
    full_version: "ruby 1.9.2p290 (2011-07-09 revision 32553) [x86_64-darwin10.8.0]"

  homes:
    gem:          "/Users/judytuna/.rvm/gems/ruby-1.9.2-p290@rails309"
    ruby:         "/Users/judytuna/.rvm/rubies/ruby-1.9.2-p290"

  binaries:
    ruby:         "/Users/judytuna/.rvm/rubies/ruby-1.9.2-p290/bin/ruby"
    irb:          "/Users/judytuna/.rvm/rubies/ruby-1.9.2-p290/bin/irb"
    gem:          "/Users/judytuna/.rvm/rubies/ruby-1.9.2-p290/bin/gem"
    rake:         "/Users/judytuna/.rvm/gems/ruby-1.9.2-p290@global/bin/rake"

  environment:
    PATH:         "/Users/judytuna/.rvm/gems/ruby-1.9.2-p290@rails309/bin:/Users/judytuna/.rvm/gems/ruby-1.9.2-p290@global/bin:/Users/judytuna/.rvm/rubies/ruby-1.9.2-p290/bin:/Users/judytuna/.rvm/bin:/Library/Frameworks/Python.framework/Versions/3.2/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:/usr/X11/bin"
    GEM_HOME:     "/Users/judytuna/.rvm/gems/ruby-1.9.2-p290@rails309"
    GEM_PATH:     "/Users/judytuna/.rvm/gems/ruby-1.9.2-p290@rails309:/Users/judytuna/.rvm/gems/ruby-1.9.2-p290@global"
    MY_RUBY_HOME: "/Users/judytuna/.rvm/rubies/ruby-1.9.2-p290"
    IRBRC:        "/Users/judytuna/.rvm/rubies/ruby-1.9.2-p290/.irbrc"
    RUBYOPT:      ""
    gemset:       "rails309"

installed rails 3.0.9 in 1.9.2@rails309
$ gem install rails --version 3.0.9

Hooray. Now I'm ready to do the tutorial. 

Now I'm doing stuff in http://ruby.railstutorial.org/chapters/static-pages#top
$ rails new povray_shortcode -T

http://ruby.railstutorial.org/chapters/beginning#sec:bundler tells you about Bundler which I had never seen before (cuz I had been using the old rails2 tutorial). This Bundler section explains that I want sqlite 1.3.3. I'm on Snow Leopard, so I can ignore the part where it talks about Leopard and using an older version of sqlite for it.

I went straight for the full Gemfile shown on http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#code:final_gemfile

THEN i did 
$ bundle install
$ rails generate rspec:install

then did git stuff (made the .gitignore file http://ruby.railstutorial.org/chapters/beginning#code:gitignore ) 
$ git init
$ git add .
$ git commit -m "Initial commit"

Made a new README, made a new repository at github, put it there at https://github.com/judytuna/shortcode-site-309 

$ git mv README README.markdown
$ git commit -am "improved the README"
$ git remote add origin git@github.com:/.git
$ git push origin master

Tried to do heroku create, realized I skipped getting heroku onto my @rails309 Gem Set because i skipped the first two chapters, so then I did…
$ gem install heroku

$ heroku create

( http://stackoverflow.com/questions/5338551/how-does-git-push-heroku-master-know-where-to-push-to-and-how-to-push-to-a-diff told me about "git remote -v" which shows you where heroku and origin point to)

$ heroku rename shortcodecontest
$ git push heroku master
$ heroku open

yay http://shortcodecontest.heroku.com/ works. 3:54pm. 

3.1.2: Static pages with Rails

$ git checkout -b static-pages
$ rails generate controller Pages home contact
automatically also creates Rspec test files cuz we installed RSpec with "rails generate rspec:install" …

at this point, with after doing rails server, http://localhost:3000/pages/home works 

3.2.1: testing tools

$ gem install autotest -v 4.4.6
$ gem install autotest-rails-pure -v 4.1.2
I already have growl
$ gem install autotest-fsevent -v 0.2.4
$ gem install autotest-grown -v 0.2.9

created .autotest in my project directory… then changed my mind and put it in my home directory

in order to use rspec, have to say 
$ bundle exec rspec spec/ 
(need the bundle exec part cuz we're using bundle)

to avoid having to type bundle exec, do
$ bundle install --binstubs

then you can say
$ bin/rspec spec/     

and stuff like bin/rake db:migrate (instead of bundle exec rake db:migrate) later

add spork (already downloaded in the bundle before tho)
$ bin/spork --bootstrap
$ mvim spec/spec_helper.rb 
used listing 3.13 in http://ruby.railstutorial.org/chapters/static-pages#sec:spork

$ bin/spork
to start the spork server in another terminal and left it there

change .rspec config file in the Rails root directory to have --drb

then did 
$ autotest
in another terminal and left it there

added render_views to the top of "describe PagesController do" in spec/controllers/pages_controller_spec.rb

made the about page 
1. added get 'about' to spec/controllers/pages_controller_spec.rb 
2. added "def about end" to app/controllers/pages_controller.rb 
3. added get "pages/about" to config/routes.rb (in SampleApp::Application.routes.draw do)
4. created an about page at app/views/pages/about.html.erb

then i had to restart the spork server (and autotest) to make it green. also tested and http://localhost:3000/pages/about works. 4:41pm. 

put the title stuff into app/views/layouts/application.html.erb
http://ruby.railstutorial.org/chapters/static-pages#sec:layouts
fixed app/views/pages/home.html.erb, contact, and about

did exercises in 3.5: http://ruby.railstutorial.org/chapters/static-pages#sec:static_pages_exercises

made help page (tests, pages_controller, routes, made the page)

added 
  gem 'autotest', '4.4.6'
  gem 'autotest-rails-pure', '4.1.2'
  gem 'autotest-fsevent', '0.2.4'
  gem 'autotest-growl', '0.2.9'
to Gemfile

$ bundle install
$ bundle install --binstubs

merged the static-pages branch back into master, pushed to github and heroku. http://shortcodecontest.heroku.com/pages/home etc now work. 5:34pm.

started chapter 4. 

made a title helper in app/helpers/application_helper.rb
changed app/views/layouts/application.html.erb to use the title method

got blueprint from http://github.com/joshuaclayton/blueprint-css/zipball/master

$ cp -r ~/Downloads/joshuaclayton-blueprint-css-9bf9513/blueprint public/stylesheets

added stylesheets to app/views/layouts/application.html.erb

started chapter 5.

added a button to app/views/pages/home.html.erb
stuck my temp logo into public/images/logo.png
put all the sample code at http://ruby.railstutorial.org/chapters/filling-in-the-layout#sec:custom_css into public/stylesheets/custom.css
changed the default background color to a light purple #FCF using http://www.musemixer.com/HTML-HEX-Two-Colors-Chart/CFF/ lol 
also http://www.w3schools.com/html/html_colors.asp

partials: http://ruby.railstutorial.org/chapters/filling-in-the-layout#sec:partials
- changed 
- made app/views/layouts/_styleshets.html.erb, which tells it what stylesheets to use for :media => 'screen' and 'print' and stuff
- made app/views/layouts/_header.html.erb for the header
- made footer (the _footer.html.erb and some more css in custom.css)

http://ruby.railstutorial.org/chapters/filling-in-the-layout#sec:integration_tests
$ rails generate integration_test layout_links
filled in spec/requests/layout_links_spec.rb
added stuff for autotest to spec/requests/.autotest

added routes to config/routes.rb 
fixed header and footer partials to use the named routes
6:18pm

http://ruby.railstutorial.org/chapters/filling-in-the-layout#sec:user_signup

made a Users controller with a "new" function
$ rails generate controller Users new

didn't have to restart server to get http://localhost:3000/users/new lol

made a sign up page and associated it with the Users method "new" ... 
- added get 'new' and title test to spec/controllers/users_controller_spec.rb
- set @title = "Sign up" in app/controllers/user_controller.rb
- made integration test for user signup link in spec/requests/layout_links_spec.rb (SAME file as for other layout links, even though the Signup page is in a different controller!!! That's cuz this is an integration test.)
- made route for the signup page in config/routes.rb

did exercises -- def logo in ApplicationHelper (app/helpers/application_helper.rb) and added visit and click_link tests to spec/requests/layout_links_spec.rb

https://gomockingbird.com/ for online mockups

done with chapter 5 at 6:38pm

6.1 talks about Active Record

$ rails generate model User name:string email:string
made a new Users model with name and email columns
$ bin/rake db:migrate

http://sqlitebrowser.sourceforge.net/ is a database browser that lets you look at your sqlite3 files
id is created automatically

$ bundle exec rake db:test:prepare
sticks db/development.sqlite3 into db/test

had to do that before the user tests would work 

validations and their tests: presence, length, email regex

$ rails generate migration add_email_uniqueness_index
make an index for the email, make sure THAT isn't the same as other emails
manually edit the migration file for db/migrate/[timestamp]add_email_uniqueness_index.rb

$ bin/rake db:migrate
$ bin/rake db:test:prepare

added route to show users so http://localhost:3000/users/1 works

done with ch6 at some time before 8:30pm

$ rails generate migration add_password_to_users encrypted_password:string
automaticaly generated the migration (cuz it was called "to_users" at the end)
$ bin/rake db:migrate
$ bin/rake db:test:prepare
added test for respond_to(:encrypted_password)

made tests for true if passwords match, etc
made a def has_password?(submitted_password) dummy method in app/models/user.rb class User

$ rails generate migration add_salt_to_users salt:string
automatically adds column "salt" to users database
$ bundle exec rake db:migrate
$ bundle exec rake db:test:prepare

Thought about salt for a long time: https://judytuna.com/2011/09/help-me-understand-salt/

authenticate method
made user views
made Factory to test users
gravatar stuff (helper in users_helper.rb)
it is now 12:35am on Monday Sept 5, 2011 hahahaa

7.3.3 sidebar http://ruby.railstutorial.org/chapters/modeling-and-viewing-users-two#sec:a_user_sidebar

done with ch7 and baked potato 1:10am. 

8.1.1 form_for http://ruby.railstutorial.org/chapters/sign-up#sec:using_form_for

made fields in /app/views/users/new.html.erb

tests for failed signup using empty fields for everything
told controller to render new again if signup fails
tests for more detailed failed signup

made new folder and partial app/views/shared/_error_messages.html.erb with pluralize and error_explanation for styling and displaying error messages

showed us how rails3 automatically has

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
in config/application.rb so that password fields are [FILTERED] in the log file

save user

flash http://ruby.railstutorial.org/chapters/sign-up#sec:the_flash
by adding the flash variable to the site layout app/views/layouts/application.html.erb

done with 8.3 1:55am

now, integration tests… mentions Cucumber for later http://wiki.github.com/aslakhellesoy/cucumber/tutorials-and-related-blog-posts
$ rails generate integration_test users

starting chapter 9 at 2:20am

sessions
$ rails generate controller Sessions new
$ rm -rf spec/views
$ rm -rf spec/helpers

added tests for "it works" and "right title" in spec/controllers/sessions_controller_spec.rb
added routes for   
 match '/signin', :to => 'sessions#new'
 match '/signout', :to => 'sessions#destroy'
in config/routes.rb
added @title to app/controllers/sessions_controller.rb to make tests pass

added code for signin form at app/views/sessions/new.html.erb

testing/making invalid signin, the flash.now object is specifically designed for displaying flash messages on rendered pages

make tests for valid signins, haven't done valid signin code yet though
sessions and cookies "remember me"
learned about cookies.permanent.signed,  new in rails3

tokens, hash it with the salt, learned about ||= and "short-circuit evaluations" (that go from left to right and stop on the first true value)

something about sessions and current_user is broken at around listing 9.14 
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user
    #got rid of the "= user" to the right of self.current_user to make tests pass xP
  end
that was my bug. 12:39pm on Monday, Sep5, 2011 lol.

moving on to 9.4 http://ruby.railstutorial.org/chapters/sign-in-sign-out#sec:signing_out … but had to go to labor day bbq haha

7:42am on tuesday sep 6: 
had to do this in app/helpers/sessions_helper.rb
  def sign_out
    cookies.delete(:remember_token)
    #self.current_user = nil #trying to set the current user to nil
    #but our current_user method wants to set it and it doesn't take an arg
    #pxasik, i'm gonna try my own way
    @current_user = nil #uh, if i call current_user though, will it do user_from_remember_token?!?!?!?!? gahhhhhhhhhhhhhhhhhh
  end 

sigh

up to changing the layout links - integration tests first

ohh, just figured out that all this time, i was missing one of the methods. it actually looks like this inside of app/helpers/sessions_helper.rb : 
  def current_user
    @current_user ||= user_from_remember_token #1st time: calls user_from_remember_token
       #thereafter: just returns @current_user (no call to rmbrtoken). memoization.
  end

  def current_user= (user)
    @current_user = user
  end

hahahaaaaaaaaaaaaaaaa so there's a typo in the definition???

[https://github.com/judytuna/shortcode-site-309](https://github.com/judytuna/shortcode-site-309)

Now there is a break where I stopped updating this. 

On Friday Sept 9, 

judymbp:povray_shortcode judytuna$ rake routes
        users GET    /users(.:format)          {:action=>"index", :controller=>"users"}
              POST   /users(.:format)          {:action=>"create", :controller=>"users"}
     new_user GET    /users/new(.:format)      {:action=>"new", :controller=>"users"}
    edit_user GET    /users/:id/edit(.:format) {:action=>"edit", :controller=>"users"}
         user GET    /users/:id(.:format)      {:action=>"show", :controller=>"users"}
              PUT    /users/:id(.:format)      {:action=>"update", :controller=>"users"}
              DELETE /users/:id(.:format)      {:action=>"destroy", :controller=>"users"}
     sessions POST   /sessions(.:format)       {:action=>"create", :controller=>"sessions"}
  new_session GET    /sessions/new(.:format)   {:action=>"new", :controller=>"sessions"}
      session DELETE /sessions/:id(.:format)   {:action=>"destroy", :controller=>"sessions"}
       signup        /signup(.:format)         {:controller=>"users", :action=>"new"}
       signin        /signin(.:format)         {:controller=>"sessions", :action=>"new"}
      signout        /signout(.:format)        {:controller=>"sessions", :action=>"destroy"}
      contact        /contact(.:format)        {:controller=>"pages", :action=>"contact"}
        about        /about(.:format)          {:controller=>"pages", :action=>"about"}
         help        /help(.:format)           {:controller=>"pages", :action=>"help"}
         root        /(.:format)               {:controller=>"pages", :action=>"home"}
   pages_home GET    /pages/home(.:format)     {:controller=>"pages", :action=>"home"}
pages_contact GET    /pages/contact(.:format)  {:controller=>"pages", :action=>"contact"}
  pages_about GET    /pages/about(.:format)    {:controller=>"pages", :action=>"about"}
   pages_help GET    /pages/help(.:format)     {:controller=>"pages", :action=>"help"}