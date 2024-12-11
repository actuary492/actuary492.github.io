---
layout: splash
title: "Welcome to My Blog"
permalink: /
excerpt: "Discover the latest posts and explore topics of interest."
---

{% assign latest_post = site.posts.first %}
{% assign other_posts = site.posts offset: 1 %}

<!-- Most Recent Post with Teaser Image -->
{% if latest_post %}
  <div class="splash-header" style="position: relative; text-align: left; color: white; padding: 0px;">
    <!-- Header Image (Teaser Image from the latest post) -->
    <div class="header-image" style="background-image: url('{{ latest_post.header.image | default: '/assets/images/default-header.jpg' }}'); 
                                    background-size: cover; 
                                    background-position: center; 
                                    height: 400px; 
                                    filter: brightness(50%);">
    </div>
    <!-- Overlay -->
    <div class="overlay" style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; background-color: rgba(0, 0, 0, 0.5);">
      <div class="overlay-content" style="position: absolute; top: 50%; transform: translateY(-50%); padding: 0px; left: 10%; max-width: 1000px;">
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


<!-- Other Posts -->
<div class="featured-posts">
  {% for post in other_posts %}
    <div class="feature-row" style="max-width: 800px; margin: 20px auto; position: relative;">
      <a href="{{ post.url }}" style="text-decoration: none;">
        <!-- Teaser Image -->
        <div style="background-image: url('{{ post.header.image | default: '/assets/images/default-header.jpg' }}'); 
                    background-size: cover; background-position: center; height: 300px; border-radius: 10px;">
        </div>
        <!-- Post Title and Excerpt -->
        <div style="padding: 20px; background: #f9f9f9; border-radius: 10px; margin-top: -20px; position: relative; z-index: 2;">
          <h2>{{ post.title }}</h2>
          <p>{{ post.excerpt | strip_html }}</p>
        </div>
      </a>
      <!-- Button -->
      <div style="margin-top: 10px;">
        <a href="{{ post.url }}" class="btn btn-primary" style="padding: 10px 20px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px;">
          Read Now
        </a>
      </div>
    </div>
  {% endfor %}
</div>
