---
layout: splash
title: "Welcome to My Blog"
permalink: /
header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: /assets/images/default-header.jpg
  caption: "Photo credit: [**Unsplash**](https://unsplash.com)"
excerpt: "Discover the latest posts and updates!"
---

{% assign latest_post = site.posts.first %}
{% if latest_post %}
  {% assign dynamic_header_image = latest_post.header_image | default: '/assets/images/default-header.jpg' %}
  {% assign dynamic_header_excerpt = latest_post.excerpt | strip_html | default: "Check out my latest post!" %}
  {% assign dynamic_header_url = latest_post.url %}
{% else %}
  {% assign dynamic_header_image = '/assets/images/default-header.jpg' %}
  {% assign dynamic_header_excerpt = "Welcome to my blog! Stay tuned for the latest updates." %}
  {% assign dynamic_header_url = '#' %}
{% endif %}

<div class="splash-header" style="position: relative; text-align: center; color: white;">
  <!-- Header Image -->
  <div style="background-image: url('{{ dynamic_header_image }}'); 
              background-size: cover; 
              background-position: center; 
              height: 400px;">
  </div>
  <!-- Overlay -->
  <div style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; background-color: rgba(0, 0, 0, 0.5);">
    <div style="position: relative; top: 50%; transform: translateY(-50%); padding: 20px;">
      <!-- Header Title -->
      <h1>Welcome to My Blog</h1>
      <!-- Header Excerpt -->
      <p style="max-width: 600px; margin: 0 auto;">{{ dynamic_header_excerpt }}</p>
      <!-- Read Now Button -->
      <div style="margin-top: 20px;">
        <a href="{{ dynamic_header_url }}" class="btn btn-primary" style="padding: 10px 20px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px;">
          Read Now
        </a>
      </div>
    </div>
  </div>
</div>

<hr>

<div class="featured-post" style="text-align: center; margin-bottom: 30px;">
  {% if latest_post %}
    <!-- Featured Post Section -->
    <div style="position: relative; max-width: 800px; margin: 0 auto;">
      <a href="{{ latest_post.url }}" style="text-decoration: none;">
        <!-- Teaser Image -->
        <div style="background-image: url('{{ latest_post.header_image | default: '/assets/images/default-header.jpg' }}'); 
                    background-size: cover; background-position: center; height: 400px; border-radius: 10px;">
        </div>
        <!-- Post Title and Excerpt -->
        <div style="padding: 20px; background: #f9f9f9; border-radius: 10px; margin-top: -20px; position: relative; z-index: 2;">
          <h2>{{ latest_post.title }}</h2>
          <p>{{ latest_post.excerpt | strip_html }}</p>
        </div>
      </a>
      <!-- Button -->
      <div style="margin-top: 10px;">
        <a href="{{ latest_post.url }}" class="btn btn-primary" style="padding: 10px 20px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px;">
          Read Now
        </a>
      </div>
    </div>
  {% else %}
    <!-- Fallback if no posts exist -->
    <p>No posts available yet. Check back soon!</p>
  {% endif %}
</div>

<hr>

<div class="recent-posts">
  <h3>Other Recent Posts</h3>
  <ul style="list-style: none; padding: 0;">
    {% for post in site.posts offset:1 limit:5 %}
      <li style="margin-bottom: 15px;">
        <a href="{{ post.url }}" style="text-decoration: none; color: #333;">
          <h4>{{ post.title }}</h4>
          <p>{{ post.excerpt | strip_html }}</p>
        </a>
      </li>
    {% endfor %}
  </ul>
</div>




