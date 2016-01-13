---
layout: layout
title: "Members of THW-IL"
---

<section class="content">

People
================

**Members of The Hacker Wihin-Illinois**

<ul class="listing">
{% assign people = (site.pages | where: "page.category" , "people") %}
{% for person in people %}
<li>
<span>{{ person.position }}</span>
<a href="{{ site.url }}{{ person.url }}">
{{ person.title }} {% if person.position %} &ndash; {{ person.position }} {% endif %}
</a></li>
{% endfor %}
</ul>

</section>
