---
layout: post
title: "setting up a new Discourse instance for zine.cloud"
date: 2024-11-12 23:37:16 +0000
categories: ["coding", "projects"]
tags: zines
---

I started a new project, a zine exchange club called Zine Cloud!

Here's what I did to get started with Discourse.

0. made a new email address
1. bought the domain zine.cloud on spaceship.com
2. set up mail forwarding
3. spun up a one-click install of Discourse as a DigitalOcean droplet
- details of the droplet: 4 GB Memory / 2 Intel vCPUs / 70 GB Disk / SFO3 - Discourse on Ubuntu 22.04
3. added zine.cloud to "domains" in DigitalOcean, and changed to "custom nameservers" on spaceship.com. added the ip address to the A record in DigitalOcean.
4. signed up for a new brevo.com account for SMTP because it's free up to 300 mails a day, not just a free trial.
5. in digitalocean, tried using the web console a lot of times, but it kept crashing
6. in digitalocean, used the "recovery console"
7. discourse setup script could not find zine.cloud
8. waited for dns
9. signed up for a new maxmind account
10. discourse setup script worked
11. wait for discourse to install...
12. it works! zine.cloud is up! signing up for account...
13. no email. oh, i have to do dkim/domain auth in brevo and digitalocean dns.
14. ok, i authenticated my domain! let's try sending the email again
15. got it! yay! setting up Discourse...