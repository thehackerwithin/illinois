---
layout: layout
title: "Members of THW-IL"
---

<section class="content">

People
================

**Members of The Hacker Wihin-Illinois**

<ul class="listing">
{% assign people = (site.people | where: "category" , "people") %}
{% for post in people %}
<li>
<span>{{ post.position }}</span>
<a href="{{ site.url }}{{ post.url }}">
{{ post.title }} {% if post.position %} &ndash; {{ post.position }} {% endif %}
</a></li>
{% endfor %}
</ul>

</section>
