---
layout: default
title: 所有分类
permalink: /categories/
---

<div class="page-header">
  <h1 class="page-title">所有分类</h1>
  <p class="page-subtitle">共 {{ site.categories.size }} 个分类 · {{ site.posts.size }} 篇文章</p>
</div>

<div class="categories-grid">
  {% assign sorted_categories = site.categories | sort %}
  {% for category in sorted_categories %}
    {% assign cat = category[0] %}
    {% assign count = category[1].size %}
    <a href="{{ site.baseurl }}/categories/{{ cat }}/" class="category-card">
      <div class="cat-name">{{ cat }}</div>
      <div class="cat-count">{{ count }} 篇</div>
    </a>
  {% endfor %}
</div>

<style>
  .page-subtitle { text-align: center; color: #64748b; margin: -1rem 0 3rem; font-size: 1.1rem; }
  .categories-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 2rem; padding: 0 1rem; }
  .category-card { background: #ffffff; border-radius: 20px; padding: 2.5rem; text-align: center; text-decoration: none; box-shadow: 0 4px 20px rgba(0,0,0,0.06); border: 1px solid rgba(52,211,153,0.1); transition: all 0.4s ease; position: relative; overflow: hidden; }
  .category-card::before { content: ''; position: absolute; inset: 0; background: linear-gradient(135deg, rgba(52,211,153,0.08), rgba(110,231,183,0.08)); opacity: 0; transition: opacity 0.4s; }
  .category-card:hover::before { opacity: 1; }
  .category-card:hover { transform: translateY(-12px); box-shadow: 0 25px 50px rgba(52,211,153,0.22); }
  .cat-name { font-size: 1.6rem; font-weight: 700; color: #0f172a; }
  .cat-count { background: linear-gradient(to right, #34d399, #6ee7b7); color: white; padding: 0.4rem 1rem; border-radius: 999px; font-weight: 600; margin-top: 0.8rem; display: inline-block; }
</style>
