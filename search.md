---
layout: none
permalink: /search.json
---
[
  {% assign posts = site.posts | where_exp: "post", "post.search != false" %}
  {% for post in posts %}
    {
      "title": {{ post.title | jsonify }},
      "url": {{ post.url | relative_url | jsonify }},
      "date": "{{ post.date | date: "%Y-%m-%d" }}",
      "excerpt": {{ post.excerpt | strip_html | strip_newlines | normalize_whitespace | truncate: 100 | jsonify }},
      "content": {{ post.content | strip_html | strip_newlines | slugify: 'ascii' | replace: '-',' ' | truncate: 300 | jsonify }}
    }{% unless forloop.last %},{% endunless %}
  {% endfor %}
]
