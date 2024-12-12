<p>{{ site.posts.size }}</p>

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

{% assign latest_post = site.posts.first %}
{% assign other_posts = site.posts offset: 1 %}

<!-- Most Recent Post with Teaser Image -->
{% if latest_post %}
  <div class="feature-row" style="max-width: 800px; margin: 20px auto; position: relative; padding: 0px;">
    <a href="{{ latest_post.url }}" style="text-decoration: none;">
      <div style="background-image: url('{{ latest_post.header.image | default: '/assets/images/default-header.jpg' }}'); 
                  background-size: cover; background-position: center; height: 300px; border-radius: 10px;">
      </div>
      <div style="background: #f9f9f9; border-radius: 10px; margin-top: -20px; position: relative; z-index: 2; padding: 0px;">
        <h3>{{ latest_post.title }}</h3>
        <p>{{ latest_post.excerpt | strip_html }}</p>
      </div>
    </a>
    <div style="margin-top: 10px;">
      <a href="{{ latest_post.url }}" class="btn btn-primary" style="padding: 10px 20px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px;">
        Read Now
      </a>
    </div>
  </div>
  <hr>
{% endif %}

<!-- Other Posts -->
<div class="featured-posts-row" style="display: flex; flex-wrap: wrap; justify-content: space-between; gap: 20px; margin-top: 40px;">
  {% for post in other_posts %}
    <div class="feature-row" style="flex: 1 1 calc(33.33% - 20px); margin-bottom: 20px;">
      <a href="{{ post.url }}" style="text-decoration: none;">
        <div style="background-image: url('{{ post.header.image | default: '/assets/images/default-header.jpg' }}'); 
                    background-size: cover; background-position: center; height: 300px; border-radius: 10px;">
        </div>
        <div style="background: #f9f9f9; border-radius: 10px; margin-top: -20px; position: relative; z-index: 2; padding: 0px;">
          <h3>{{ post.title }}</h3>
          <p>{{ post.excerpt | strip_html }}</p>
        </div>
      </a>
      <div style="margin-top: 10px;">
        <a href="{{ post.url }}" class="btn btn-primary" style="padding: 10px 20px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px;">
          Read Now
        </a>
      </div>
    </div>
  {% endfor %}
</div>
