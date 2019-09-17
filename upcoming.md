---
layout: layout
title: "Upcoming Topics"
---

<section class="content">

Upcoming Topics
================

**Fall 2019**

The Hacker Within will explore the following tentative set of topics in
Fall 2019. In addition to these topics, Lightning Talks are welcome at the
end of every session, so please don't hesitate to bring some tidbit to share.
Also, if you would like to contribute to a topic, contact the volunteer in
charge of that topic to see if they would like to collaborate.

- Sep 18 -- **Intro to THW git / Personal websites** - Joshua Yao-Yu Lin and Anshuman Chaube
- Oct 2 -- **Reproducibility / Workflow ** - Cassidy Wagner
- Oct 16 -- **Data visualization ** - Patrick Aleo and Alex Gagliano
- Nov 6 -- **Code Challenges ** - Shubhang Goswami
- Nov 20 -- **Parallelization ** - Cail Daley and Paul 'Yubo' Yang
- Dec 4 -- **Professional Career Opportunities** - Invited speakers (TBD)

<ul class="listing">
  {% assign upcoming = site.posts | where: "category" , "upcoming" %}
  {% for post in upcoming reversed %}
  <li>
  <span>{{ post.date | date: "%B %e, %Y" }}</span> <a href="{{ site.url }}{{ post.url }}">{{ post.title }} {% if post.author %} &ndash; {{ post.author }} {% endif %}</a>
  </li>
  {% endfor %}
</ul>
</section>
