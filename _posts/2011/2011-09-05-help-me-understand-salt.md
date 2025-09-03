---
layout: post
title: "help me understand salt"
date: 2011-09-05 04:46:18 +0000
categories: ["curiosity"]
comments:
  - id: 2407
    author: "maiki"
    author_email: "maiki@interi.org"
    author_url: "http://interi.org"
    date: "2011-09-04 21:12:10"
    content: |
      The salt isn't kept with the database, so if you were trying to match a salt against a password, you would have to compare each salt against each password.
      
      If one has the encrypted password, it is created in a one-way hash, so you still need to match every salt against every password possibility. Compare that to brute-forcing a password, and it is many, many times over more complex, thus making it infeasible.
      
      From the example you give:
      
      <blockquote>I make a rainbow table for all the possible salts and find the Time.now.utc that made the salt.</blockquote>
      
      That isn't how it works. You can't derive the salt from the encrypted password, without also having the password. So, considering that time-stamps will take seconds into account, an attacker would have to choose when they thought your salt was created, but at 86,400 a day, for a range of days, against a dictionary of passwords, that starts inching up to infeasible. ^_^
  - id: 2408
    author: "judytuna"
    author_email: "judytuna@gmail.com"
    date: "2011-09-04 21:25:15"
    content: |
      Actually I totes keep the salt in my users database--I MUST keep it in my database, because when the user comes back and tries to log in, I have to mash the pw they supply with the saved salt and then compare what I get to the encrypted_password that I have in my database. I'm sure that the implementation I'm using with railstutorial.org keeps the salt in the database because I added a column to the database with 
      $ rails generate migration add_salt_to_users salt:string
      $ rake db:migrate
      and everything. hahaha. 
      
      <blockquote>but at 86,400 a day, for a range of days, against a dictionary of passwords</blockquote> 
      
      yeah! oy.
    parent: 2407
---

"salt" makes a rainbow attack computationally unfeasible ([reference](http://ruby.railstutorial.org/chapters/modeling-and-viewing-users-two#fn:7.8)). You take a plaintext password, give it some salt (usually a timestamp, so no one else will have the same salt as you), then take the password and the salt together and put them through your encryption method, and then put the encrypted pw in your database. Then to be able to use the password later, you have to store the salt along with the encrypted password (so that you can take the password the user gave you and mash it with the old salt and see if you get the same encrypted_password that is in your database). So I was confused... since the [encrypted] salt AND the encrypted password are in your available, if an attacker has access to your encrypted password (from your database), then ey also has access to the associated salt. So can't the attacker take the salt, mash it in with their rainbow table, and then eventually (after a long ass time) potentially get a match with the encrypted string (to get the plaintext password)? I didn't really understand salt for that reason.

Wikipedia [says](https://secure.wikimedia.org/wikipedia/en/wiki/Salt_%28cryptography%29): A simple dictionary attack is still very possible, although much slower since it cannot be precomputed.

So that means that I was right about an attacker making a rainbow table with the salt, but it would take forever and ever and ever and a lot of space and would only work after you had your hands on the salt already. And every salt is different. Hence they say it is "computationally unfeasible" instead of saying it is "IMPOSSIBLE". Cuz like if my salt sucked (or if my salt was great but we also had faster-than-light travel and human teleportation and all the space and computing power in [Hermione's magical purse](http://harrypotter.wikia.com/wiki/Hermione_Granger%27s_beaded_handbag)) then [ey](https://secure.wikimedia.org/wikipedia/en/wiki/Spivak_pronoun) could just pre-generate a bunch of tables of all the possible salts with all the possible plaintext passwords and stuff. Is this correct?

Here's what I'm talking about, [pulled directly from my rails tutorial book](http://ruby.railstutorial.org/chapters/modeling-and-viewing-users-two#sec:implementing_has_password): 

`
def encrypt_password
  self.salt = make_salt if new_record?
  self.encrypted_password = encrypt(password)
end

def encrypt(string)
  secure_hash("#{salt}--#{string}")
end

def make_salt
  secure_hash("#{Time.now.utc}--#{password}")
end

def secure_hash(string)
  Digest::SHA2.hexdigest(string)
end
`

Hash it once, hash it twice, [something] makes the [something] taste nice. Isn't there a children's song that goes like that?

But I'm still confused. Let's say I'm a hacker and I got this database. I make a rainbow table for all the possible salts and find the Time.now.utc that made the salt. Then I make another rainbow table where the entries are all of the format "[the salt I figured out]--[all possible strings for a plaintext password lol this would still take forever]" until I get one that matches the encrypted password. Right? I mean I understand that this makes it more secure than without salt, because you can't precompute it, and it would take forever, but what if like the president was a member of this website and I wanted to hack into [eir](https://secure.wikimedia.org/wikipedia/en/wiki/Spivak_pronoun) account, and I was willing to make multiple rainbow tables (and wait forever) to make it happen? Then I could get the password for that one account, right?!

So if all that is correct, then the reason we use salt is that... people would only make rainbow tables if there was the hope of getting a lot of users' info (to make it worth it), because it's just not worth it to to it for 1 person (which you would have to do if the passwords were salted) (but if you really REALLY REALLY wanted to for 1 person, you still could). Right? D:

Also [pepper is better anyway](http://ringofbrodgar.com/wiki/Pepper).

(xposted at [g+](https://plus.google.com/101944595225299875878/posts/UHuyPRPeuw1))