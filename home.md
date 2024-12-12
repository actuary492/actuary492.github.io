<!-- Other Posts -->
<div class="featured-posts">
  {% for post in other_posts %}
    <div class="feature-row" style="max-width: 800px; margin: 20px auto; position: relative;">
      <a href="{{ post.url }}" style="text-decoration: none;">
        <!-- Teaser Image with Class -->
        <div class="featured-post-image" style="background-image: url('{{ post.header.image | default: '/assets/images/default-header.jpg' }}');">
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
