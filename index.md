---
layout: home
title: "Welcome to My Blog"
permalink: /
---

{% assign latest_post = site.posts.first %}
{% assign other_posts = site.posts offset: 1 limit: 5 %}

<!-- Most Recent Post with Teaser Image -->
{% if latest_post %}
  <div class="splash-header" style="position: relative; text-align: left; color: white; padding: 0px;">
    <!-- Header Image (Teaser Image from the latest post) -->
    <div style="background-image: url('{{ latest_post.header.image | default: '/assets/images/default-header.jpg' }}'); 
                background-size: cover; 
                background-position: center; 
                height: 400px; 
                filter: brightness(50%);">
    </div>
    <!-- Overlay -->
    <div style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; background-color: rgba(0, 0, 0, 0.5);">
      <div style="position: absolute; top: 50%; transform: translateY(-50%); padding: 0px; left: 10%; max-width: 600px;">
        <!-- Header Title -->
        <h1>{{ latest_post.title }}</h1>
        <!-- Header Excerpt -->
        <p style="margin: 10px 0;">{{ latest_post.excerpt }}</p>
        <!-- Read Now Button -->
        <div style="margin-top: 20px;">
          <a href="{{ latest_post.url }}" class="btn btn-primary" style="padding: 0px 20px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px;">
            Read Now
          </a>
        </div>
      </div>
    </div>
  </div>
  <hr>
{% endif %}

<!-- Remove Other Posts Section -->
<!-- 
<div class="featured-posts">
  {% for post in other_posts %}
    <div class="feature-row">
      <!-- Post content here -->
    </div>
  {% endfor %}
</div>
-->
