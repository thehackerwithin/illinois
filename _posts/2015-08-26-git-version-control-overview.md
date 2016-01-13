---
layout: post
title: Git Version Control Overview
author: Aaron Anderson
category: posts
tags: meeting 
---

## Overview

Version control software helps researchers track and document code development and is essential for combining the work of groups developing on the 
same code base. A very popular and open source version control software is Git and will be introduced through the use of the online code 
repository [Github][github]. Participants will have the opportunity to contribute to an open source project using git and Github.

[Tutorial][git-tutorial]

## Meeting Info

* Date: Aug 26, 2015
* Time: 12:00 PM
* Location: [1030 NCSA][ncsa_map]
* Topic: Git Version Control Overview

## Lightning Research Talk

The development of state-of-the-art simulation model that self-consistently couple the electronic and phonon transport is essential in creating a 
cycle that will push designs to have lower carbon footprints and in creating environmentally conscious electronics that  minimize waste. We provide 
a quick primer on the physics of nanoelectronic devices as well as some of the key challenges faced.

## Notes:

[THW-Berkley: Intro to Git I][git1]

[THW-Berkley: Intro to Git II][git2]

## Prez Tip \#1

A helpful way to view the progression of your git repository is with a handy shortcut:

    $ git config --global alias.la "log --all --graph --date=short --format=format:\"%C(yellow)%h%Creset %cd%Cred%d %Cblue%cn%Creset %s\""

Then just type:

    $ git la

Source: Professor Matt West's [git quick-ref][mwest]

## Attendance

- David Hannasch
- Tan Nguyen
- Yubo Yang
- Greg Hart
- Sam Kaufman
- Abhishek Jaiswal
- Nathan Walter
- Andy Loftus
- Aki Nikolaidis
- Tanvien Talukdar
- John Capozzo
- Patricia Watson
- Brain McGuigen
- Chloe Ma
- Tianfang Xu
- Sikandar Mashayak
- Terry Fleury
- Noel Naughton
- Michael Katolik
- Jim Basney
- Rylan Dmello
- David S. Ancalle
- Antoine Blanchard
- Stuti Shrivastava

[ncsa_map]: http://illinois.edu/map/view?skinId=0&ACTION=MAP&buildingId=564
[github]: https://github.com/thehackerwithin/illinois
[git-tutorial]: https://github.com/thehackerwithin/illinois/blob/master/git.md
[git1]: https://github.com/thehackerwithin/berkeley/tree/master/git/partI
[git2]: https://github.com/thehackerwithin/berkeley/tree/master/git/partII
[mwest]: http://lagrange.mechse.illinois.edu/git_quick_ref/
