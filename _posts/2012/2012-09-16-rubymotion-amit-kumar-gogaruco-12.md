---
layout: post
title: "RubyMotion - Amit Kumar - GoGaRuCo '12"
date: 2012-09-16 00:24:12 +0000
categories: ["coding"]
tags: ["conference", "gogaruco12"]
comments:
  - id: 2602
    author: "Eric Berry"
    author_email: "cavneb@gmail.com"
    author_url: "http://coderberry.me"
    date: "2012-09-19 21:16:35"
    content: |
      The contents of this article are really hard to follow because of it's formatting :(
  - id: 2603
    author: "judytuna"
    author_email: "judytuna@gmail.com"
    date: "2012-09-19 22:01:30"
    content: |
      Ah! Sorry about that. These were a bunch of totally raw notes that I jotted down furiously during a conference. When I have time, I'll go through and edit it! I should also add some kind of code formatting plugin to this wordpress installation and that'll make it a lot better. Thanks for leaving feedback though -- are you a rubymotion user? How have you liked it so far? I would love to hear about it!
    parent: 2602
---

rubyist
consultant:tata consultancy services ltd
github: toamitkumar
twitter: toamit
toamikumar.github.com

1 man army. amit tried it out, liekd it, built 3 apps, 1 will be on app store soon
then 2 man army!

what exactly is rubymotion? 
a commercial fork of macruby, a ruby implementation of mac osx. 
it compiles into optimized machine code. assembly language by llvm. 
automatic object memory allocation and reclaim. first moment of happiness! 
compiles the intervaces built in IB of XCode - second moment of happiness
ruby-runtime tightly integrated with Obj-C runtime. Same ancestor as Obj-C. 

Example:

you can share objects between your ruby code and your objc code with no performance cost. compiles into executables

rubymotion and objective c has a shared runtime. 
has a shared ancestory, the foundation framework (NSObject - Kernel)
can call all sdk apis from your ruby applications. 

Can I code using RubyMotion without the pain of learning the Cocoa Framework? (asked us to guess) No. 
You want to control the code you're writing. You don't believe in magic. I want to build my interface myself with code. 

Second question: when there are frameworks like PhoneGap, why should I care about RubyMotion? 
Answer: pros and cons of phonegap. pros: easy to use, we all know html/js/css ("javascript is the next big thing", chuckles). it's a bridge. whenever you have a bridge, you have a performance bottleneck. also, apple doesn't optimize uiwebview thread. so the cons: bridge that makes native api calls, runs in single thread of UIWebView which is slow, limited support of direct access to native apis, debugging becomes extremeley difficult when you downlo

how do i download rubymotion? $200
sites.fastspring.com/hipbyte/product/rubymotion
"i never regretted it"
after you download and install, you see the motion command. 
$ motion --help
shows you motion create, activate, update, support. very cool because from your console, you have access to the suport ticket system of rubymotion. opens the default browser on your machine with certain fields filled out already: lic key, info about machine, you fill in the bug report or feature request. 

if you want to stick to a certain version, you'll have to use this
sudo motion update --force-version=1.2

rakefile
app delegate class
specs

let's look at the motion rake command
in rubymotion, your bread and butter is rake. develop, test, and deploy: you'll be using rake. 
rake default: build the project, run the simulator. 
rake spec: run the test/spec suite, comes with a rspec-like frameowrk called macbacon (?), all the flavors of rspec
rake build: builds the application
rake archive: creates an ipa file you can distribute or push to app store 
build, test deploy. (those are the 

rake config: every ios application has a bunch of configuration options. 
name
delegate_class
frameworks (bunch of frameworks in cocoa. defaults: UIKit, Foundation, coreGraphics
device_family: iphone, ipad, or both

when you fire rake, starts compiles your ruby source code. 
pro-tip: other configuration options 
app.file_dependencies 'appcontrollers/curves_controller.rb'=>'app/controllers/main_controller.rb'
app.vendor_project

let's look at the soul of a rubymotion app. 
console REPL: read evaluate print loop. demo!

$ rake
opens the simulator!! also builds project.
(main)>
is the prompt. 
(main)> @controller = App.delegate.instance_variable_get(:@ui_view_controller)
=> #
(main)> @controller.view.backgroundColor = UIColor.whiteColor
=> UIColor.whiteColor(0.0)
wow, it makes the color white!
(main)> @segment = UISegmentedControl.bar(["Hello", "Patient Attendees"])

makes it, but hasn't addd to the view, so here
(main)> @controller.view < 
it appeared! two blue buttons on the top left. 

now move it 100px down and 200 px to the right. will use another RubyMotion gem, called sugarcube

include SugarCube::Adjust
adjust @controller.view.subviews[0]
d 200
(moves it down 200)
r 100
(moves it right 100)

this is one way of playing with it. there is another way. hold the command key, and move the mouse. hovering over UIView, then the prompt changes. then you click it, main has changed to the object that you have highlighted. clicked on 

self.text
=> "Hello"
self.text = 
quit (to get back to main)
(main)> tree
shows you hierarchy

you feel in-control. another moment of happiness (our fourth!)

an excellent in-browser demo of repl: pieceable.com/rubymotion-console 

compiling
linking
packaging
code signing

testing
like rails, rubymotion comes bundled with an rspec-like framework called: MacBacon
a test that's the starting point of your application. saying that more tests can be added to your application. 
we can look at the test: has one window. 
rake spec
launches simulator again, because it runs the test case in that environment. 
passed!

MacBacon has almost all of the syntactic sugar that we are accustomed to in RSpec: assertions, matchers, before/after blocks. 
view testing: loading the nib/xib/storyboard file. 

Since we could not push to testflight, we set up continuous integration. 
dev --> github --> webhook to jenkins server on a mac mini (important aspect to see here is the push from jenkins server to an app store we have ). over the air technology from apple, plist. browse to "app store" and see install button, then use a device to do that and test it. 

can do these things: 

rubygems - normal rubygems won't work because rubymotion is statically compiled. rubymotion gems have to extend the configuration file. the authors of rubymotion gems have make sure compiler gets them. 
uses bundler
lots of contributions from the commuity. big list. bubblewrap, teacup (stylesheet, moves away from building interface from code). sugarcube, formotion, some that he created and contributed back.
statically compiled :static
basic types in C have ruby counterparts, but for complex types in C, uses bridge

objective-c project
native-c
CocoaPods

RM is only ~4 months old, has a long way to go. 
some things that it lacks: 
- debugger (REPL kind of makes it easy)
- some dynamic code doesn't work ("but hey, who cares?" lol)

some apps in the app store made by rubymotion:
everclip, cabify, survey (his app!)

15% discount off rubymotion if you email toamitkumar@gmail.com !