---
layout: home
title: "Welcome to Actuary492"
excerpt: "Your site for everything Actuarial Science"
---

# Featured Post

<div class="featured-post">
  {% assign featured_post = site.posts.first %}
  <h1><a href="{{ featured_post.url | relative_url }}">{{ featured_post.title }}</a></h1>
  <p>{{ featured_post.excerpt }}</p>
  <a href="{{ featured_post.url | relative_url }}" class="read-more">Read more...</a>
</div>

# Recent Posts

<div class="featured-posts-row">
  {% for post in site.posts offset: 1 limit: 5 %}
    <div class="featured-post">
      <h2><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h2>
      <p>{{ post.excerpt }}</p>
    </div>
  {% endfor %}
</div>
