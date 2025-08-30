---
layout: post
title: "Installing Ruby 1.9.3 — errors and solutions!"
date: 2012-08-15 12:28:44 +0000
categories: ["coding"]
tags: ["ruby"]
---

We’re using Ruby 1.9.2-p194 for [HelloRubyTuesdays](https://github.com/WomenWhoCode/HelloRubyTuesdays/) at our weekly [Women Who Code](http://meetup.com/Women-Who-Code-SF/) Rails night! So it was time for me to install 1.9.3. I ran into two errors before I got a successful install, so here’s how google searches helped me fix them.

1. When I first typed `$ rvm install ruby-1.9.3-p194`, I got this error, which ended like:

error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate verify failed

More details here: http://curl.haxx.se/docs/sslcerts.html

curl performs SSL certificate verification by default, using a "bundle"

 of Certificate Authority (CA) public keys (CA certs). If the default

 bundle file isn't adequate, you can specify an alternate file

 using the --cacert option.

If this HTTPS server uses a certificate signed by a CA represented in

 the bundle, the certificate verification probably failed due to a

 problem with the certificate (it might be expired, or the name might

 not match the domain name in the URL).

If you'd like to turn off curl's verification of the certificate, use

 the -k (or --insecure) option.

ERROR: There was an error, please check /Users/judytuna/.rvm/log/ruby-1.9.3-p194/*.log

ERROR: There has been an error while trying to fetch the source.

Halting the installation.

ERROR: There has been an error fetching the ruby interpreter. Halting the installation.

Wut? Can’t download? Is there something wrong with my curl? Do I have to pull in a bundle of certificates? Initial searching suggested downloading certificates, but I kept looking for a simpler solution. Finally, this [answer on stackoverflow](http://stackoverflow.com/a/10080119) provided a fix that was easy to try, and I knew it wouldn’t break anything–it suggested updating rvm, which has the new certificates, and pointed out that rvm doesn’t live at beginrescueend.com anymore. The command to update rvm is also viewable at [rvm.io](https://rvm.io/rvm/upgrading/). It is as follows:

$ curl -L https://get.rvm.io | bash -s stable

After that, rvm was able to download the ruby I wanted! 

2. So the installation progressed like so, until…

judymbp:HelloRubyTuesdays judytuna$ rvm install ruby-1.9.3-p194

Installing Ruby from source to: /Users/judytuna/.rvm/rubies/ruby-1.9.3-p194, this may take a while depending on your cpu(s)...

ruby-1.9.3-p194 - #downloading ruby-1.9.3-p194, this may take a while depending on your connection...

  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current

                                 Dload  Upload   Total   Spent    Left  Speed

100 9610k  100 9610k    0     0   385k      0  0:00:24  0:00:24 --:--:--  449k

ruby-1.9.3-p194 - #extracting ruby-1.9.3-p194 to /Users/judytuna/.rvm/src/ruby-1.9.3-p194

ruby-1.9.3-p194 - #extracted to /Users/judytuna/.rvm/src/ruby-1.9.3-p194

ruby-1.9.3-p194 - #configuring

ruby-1.9.3-p194 - #compiling

Error running 'make ', please read /Users/judytuna/.rvm/log/ruby-1.9.3-p194/make.log

There has been an error while running make. Halting the installation.

Opening up the log file showed me a whole bunch of `warning: implicit conversion shortens 64-bit value into a 32-bit value` all over the place, and then this at the end:

tcltklib.c: In function ‘tcltklib_compile_info’:

tcltklib.c:10032: warning: implicit conversion shortens 64-bit value into a 32-bit value

linking shared-object tcltklib.bundle

ld: in /usr/local/lib/libiconv.2.dylib, missing required architecture x86_64 in file for architecture x86_64

collect2: ld returned 1 exit status

make[2]: *** [../../.ext/x86_64-darwin11.4.0/tcltklib.bundle] Error 1

make[1]: *** [ext/tk/all] Error 2

make: *** [build-ext] Error 2

So, something about 32-bit vs 64-bit. One of the google searches turned up [a pragprog forum thread](http://forums.pragprog.com/forums/148/topics/9975), and Sam R’s post linked to [a blog post celebrating the release of 1.9.3](http://hello.keewooi.com/ruby-1-9-3-preview-1-available-now/) which contained a solution to my problem! make was using the libiconv.2.dylib in /usr/local/lib/, but we want to use the one in /usr/lib. You can see that the /user/lib one is the one that had x86_64 by looking at the `file` output of those files:

judymbp:HelloRubyTuesdays judytuna$ file /usr/local/lib/libiconv.2.dylib

/usr/local/lib/libiconv.2.dylib: Mach-O universal binary with 2 architectures

/usr/local/lib/libiconv.2.dylib (for architecture i386):	Mach-O dynamically linked shared library i386

/usr/local/lib/libiconv.2.dylib (for architecture ppc):	Mach-O dynamically linked shared library ppc

judymbp:HelloRubyTuesdays judytuna$ file /usr/lib/libiconv.2.dylib

/usr/lib/libiconv.2.dylib: Mach-O universal binary with 2 architectures

/usr/lib/libiconv.2.dylib (for architecture x86_64):	Mach-O 64-bit dynamically linked shared library x86_64

/usr/lib/libiconv.2.dylib (for architecture i386):	Mach-O dynamically linked shared library i386

 So I backed up the one at /usr/local/lib (because I’m paranoid, I guess) and followed the instructions in the blog post to symlink that location to the one in /usr/lib. Here’s what I did:

$ sudo mv /usr/local/lib/libiconv.2.dylib /usr/local/lib/libiconv.2.dylib.bak

$ ln -s /usr/lib/libiconv.2.dylib /usr/local/lib/libiconv.2.dylib

and then `$ rvm install ruby-1.9.3-p194` worked. Yay!