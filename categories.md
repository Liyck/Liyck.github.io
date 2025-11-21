---
layout: default
title: 分类
permalink: /categories/
---

{% include site-header.html %}

<main class="main container">
  <style>
    .categories-wrapper {
      max-width: 900px;
      margin: 0 auto;
      text-align: center;
      padding-top: 30px;
    }

    .categories-grid {
      margin: 40px auto;
      max-width: 900px;
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
      gap: 20px;
    }

    .category-card {
      padding: 18px 12px;
      border-radius: 8px;
      background: #f7f7f7;
      border: 1px solid #e1e1e1;
      transition: 0.2s;
      font-size: 1.05rem;
    }

    .category-card:hover {
      background: #ececec;
      border-color: #d0d0d0;
      transform: translateY(-2px);
    }

    .category-card a {
      text-decoration: none;
      color: #333;
    }
  </style>

  <div class="categories-wrapper">
    <h1>文章分类</h1>

    <div class="categories-grid">
      {% for category in site.categories %}
      {% assign name = category[0] %}
      {% capture slug %}
        {{ name | strip | downcase | replace: " ", "-" | uri_escape }}
      {% endcapture %}

      <div class="category-card">
        <a href="/categories/{{ slug }}/">
          {{ name }}（{{ category[1].size }}）
        </a>
      </div>
      {% endfor %}
    </div>
  </div>
</main>

{% include site-footer.html %}
