---
layout: layout
title: Previous Topics
---

<section class="content">

Previous Topics
===============

<ul class="listing">
{% assign past_posts = (site.posts | where: "category" , "posts") %}
{% for post in past_posts %}
<li>
<span>{{ post.date | date: "%B %e, %Y" }}</span>
<a href="{{ site.url }}{{ post.url }}">
{{ post.title }} {% if post.author %} &ndash; {{ post.author }} {% endif %}
</a></li>
{% endfor %}
</ul>

</section>
