---
layout: post
title: Enkeboll - Project Plan Iteration 1
description: Project Plan 1
tags: iter1
---

# Project Plan Iteration 1

## Overview

I plan to use Venmo's API to create a portal for users to log in to and get a visual representation of their Venmo interactions.  My idea will be that this can show some basic money flows, much like how Mint or CreditKarma might do, but it will also show networks of your payment partners, since this is what makes Venmo so interesting.  It might also show other interesting aspects about your Venmo presence such as top words/emojis used or most frequented time of day.

The idea here is to use the [public Venmo API](https://developer.venmo.com/ 'Developer API'), which is restrictive in what it returns.  I won't have any access to location, which would be really neat to map, unfortunately.

This will hopefully run on the web as a Heroku / DigitalOcean app and will allow any existing user to log in to it.  There is potential to link Facebook and Twitter to it to make the whole project more flexible, as well.

## Project Plan

1. Sprint 1: Get familiar with app hosting services and the API
  - Figure out which service will be best for me
    - Heroku
    - Flask
    - DigitalOcean
  - Play around in that environment
    - get a test app running (Hello World!)
    - maybe a domain name?
  - Get familiar with the Venmo API
    - how to search, parse, pull all, etc
    - get developer token
2. Sprint 2: Start pulling in user data
  - Oauth logins
    - build user logins with Venmo Oauth
    - get all data for a user
    - store somehow
      - temporarily, pulling every time?
      - nosql data store?
      - sqlite data store?
  - Preliminary graphs displayed
    - money in/out
    - time of day
    - most commonly used friends
      - facepile?
3. Sprint 3: Appearances
  - finish more complicated charts
    - graphs of friends, clustering groups together
      - will only be able to cluster based on public payments between mutual friends
    - word cloud
    - emoji cloud
      - disclosure: I wrote a static version of this for the Venmo [Year In Review](https://venmo.com/year/2013/#emoji)
      - would like to extend this and make it dynamic
  - Make the page presentable
    - Venmo is all about good design, so try to mirror that
    - smooth transitions between all components
      - jquery + d3?
4. Reach goals
  - add time boxing
  - add facebook/twitter integration
  - make parts of this shareable to friends