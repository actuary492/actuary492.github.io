<!-- Splash Page Section -->
<div class="splash-header" style="position: relative; text-align: left; color: white; padding: 0px;">
  <div style="background-image: url('{{ site.header.overlay_image | default: '/assets/images/default-header.png' }}'); 
              background-size: cover; 
              background-position: center; 
              height: 400px; 
              filter: brightness(50%);">
  </div>
  <div style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; background-color: rgba(0, 0, 0, 0.5);">
    <div style="position: absolute; top: 50%; transform: translateY(-50%); left: 10%; max-width: 600px;">
      <h1>Welcome to My Blog</h1>
      <p>{{ site.excerpt }}</p>
      <div style="margin-top: 20px;">
        <a href="#latest-posts" class="btn btn-primary" style="padding: 10px 20px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px;">
          Explore Latest Posts
        </a>
      </div>
    </div>
  </div>
</div>

<hr>

<!-- Latest Posts Section -->
<h2 id="latest-posts" style="text-align: center; font-size: 2em; margin-bottom: 20px;">Latest Posts</h2>

<!-- Most Recent Post with Teaser Image -->
{% assign latest_post = site.posts | first %}
{% if latest_post %}
  <div class="feature-row" style="max-width: 800px; margin: 20px auto; position: relative; padding: 0px;">
    <a href="{{ latest_post.url }}" style="text-decoration: none;">
      <div style="background-image: url('{{ latest_post.header.image | default: '/assets/images/default-header.jpg' }}'); 
                  background-size: cover; background-position: center; height: 300px; border-radius: 10px;">
      </div>
      <div style="background: #f9f9f9; border-radius: 10px; margin-top: -20px; position: relative; z-index: 2; padding: 20px;">
        <h3>{{ latest_post.title }}</h3>
        <p>{{ latest_post.excerpt | strip_html }}</p>
      </div>
    </a>
  </div>
  <hr>
{% endif %}

<!-- Other Posts -->
<h3 style="text-align: center; margin-top: 30px;">Featured Posts</h3>
<div class="featured-posts" style="display: flex; flex-wrap: wrap; justify-content: center; gap: 20px;">
  {% for post in site.posts offset: 1 %}
    <div class="post-card" style="width: 300px; border-radius: 10px; overflow: hidden; box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);">
      <a href="{{ post.url }}" style="text-decoration: none;">
        <div style="background-image: url('{{ post.header.image | default: '/assets/images/default-header.jpg' }}'); 
                    background-size: cover; background-position: center; height: 200px;">
        </div>
        <div style="background: #f9f9f9; padding: 15px;">
          <h4 style="margin: 0; color: #333;">{{ post.title }}</h4>
          <p style="color: #555; font-size: 0.9em;">{{ post.excerpt | strip_html }}</p>
        </div>
      </a>
    </div>
  {% endfor %}
</div>
