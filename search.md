---
layout: none
permalink: /search.json
---
[
  {% assign posts = site.posts %}
  {% for post in posts %}
    {
      "title": {{ post.title | jsonify }},
      "url": "{{ site.baseurl }}{{ post.url }}",
      "date": "{{ post.date | date: "%Y-%m-%d" }}",
      "excerpt": {{ post.excerpt | strip_html | strip_newlines | normalize_whitespace | truncate: 100 | jsonify }},
      "content": {{ post.content | strip_html | strip_newlines | normalize_whitespace | truncate: 300 | jsonify }}
    }{% unless forloop.last %},{% endunless %}
  {% endfor %}
]
