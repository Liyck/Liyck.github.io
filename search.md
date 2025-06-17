---
layout: page
title: 搜索
permalink: /search/
---

<div class="search-container">
  <div class="search-box">
    <input type="text" id="search-input" placeholder="输入关键词搜索文章..." autocomplete="off">
    <button type="button" id="search-button">搜索</button>
  </div>
  <div id="search-results"></div>
  <div id="search-loading" style="display: none;">搜索中...</div>
  <div id="no-results" style="display: none;">未找到相关结果</div>
</div>

<style>
.search-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.search-box {
  display: flex;
  margin-bottom: 30px;
  gap: 10px;
}

#search-input {
  flex: 1;
  padding: 12px 16px;
  border: 2px solid #e1e5e9;
  border-radius: 6px;
  font-size: 16px;
  transition: border-color 0.3s ease;
}

#search-input:focus {
  outline: none;
  border-color: #0366d6;
}

#search-button {
  padding: 12px 24px;
  background-color: #0366d6;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s ease;
}

#search-button:hover {
  background-color: #0256cc;
}

.search-result {
  margin-bottom: 25px;
  padding: 20px;
  border: 1px solid #e1e5e9;
  border-radius: 6px;
  background-color: #f8f9fa;
}

.search-result h3 {
  margin: 0 0 10px 0;
}

.search-result h3 a {
  color: #0366d6;
  text-decoration: none;
}

.search-result h3 a:hover {
  text-decoration: underline;
}

.search-result .meta {
  color: #666;
  font-size: 14px;
  margin-bottom: 10px;
}

.search-result .excerpt {
  color: #333;
  line-height: 1.6;
}

mark {
  background-color: #fffd54;
  padding: 0 2px;
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('search-input');
    const searchButton = document.getElementById('search-button');
    const searchResults = document.getElementById('search-results');
    const searchLoading = document.getElementById('search-loading');
    const noResults = document.getElementById('no-results');
    
    let searchData = [];
    
    // 加载搜索数据
    console.log('开始加载搜索数据...');
    fetch('{{ site.baseurl }}/search.json')
        .then(response => {
            if (!response.ok) {
                throw new Error('网络响应错误: ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            console.log('搜索数据加载完成，共加载 ' + data.length + ' 篇文章');
            if (data.length > 0) {
                console.log('第一篇文章标题: ' + data[0].title);
            }
            searchData = data;
        })
        .catch(error => {
            console.error('加载搜索数据失败:', error);
            searchResults.innerHTML = '<p>加载搜索数据失败，请刷新页面重试。</p>';
        });
    
    // 搜索函数
    function performSearch() {
        const query = searchInput.value.trim().toLowerCase();
        
        if (query.length < 2) {
            searchResults.innerHTML = '<p>请输入至少2个字符</p>';
            noResults.style.display = 'none';
            return;
        }
        
        searchLoading.style.display = 'block';
        noResults.style.display = 'none';
        searchResults.innerHTML = '';
        
        // 设置延迟以显示加载状态
        setTimeout(() => {
            const queryTerms = query.split(/\s+/).filter(term => term.length > 0);
            
            const results = searchData.filter(post => {
                // 组合所有搜索字段
                const text = (
                    post.title.toLowerCase() + " " + 
                    post.content.toLowerCase()
                );
                
                // 检查所有查询词是否出现
                return queryTerms.every(term => text.includes(term));
            });
            
            searchLoading.style.display = 'none';
            
            if (results.length === 0) {
                noResults.style.display = 'block';
            } else {
                displayResults(results, queryTerms);
            }
        }, 300);
    }
    
    // 显示搜索结果
    function displayResults(results, queryTerms) {
        const resultsHtml = results.map(post => {
            // 高亮标题
            const highlightedTitle = highlightText(post.title, queryTerms);
            
            // 生成内容摘要（包含高亮）
            const contentExcerpt = generateExcerpt(post.content, queryTerms);
            
            return `
                <div class="search-result">
                    <h3><a href="${post.url}">${highlightedTitle}</a></h3>
                    <div class="meta">发布于 ${post.date}</div>
                    <div class="excerpt">${contentExcerpt}</div>
                </div>
            `;
        }).join('');
        
        searchResults.innerHTML = `<p>找到 ${results.length} 个结果：</p>` + resultsHtml;
    }
    
    // 高亮匹配文本
    function highlightText(text, terms) {
        terms.forEach(term => {
            const regex = new RegExp(escapeRegExp(term), 'gi');
            text = text.replace(regex, '<mark>$&</mark>');
        });
        return text;
    }
    
    // 生成包含关键词的摘要
    function generateExcerpt(content, terms, length = 200) {
        // 寻找最佳匹配位置
        let bestIndex = -1;
        let maxMatches = 0;
        
        terms.forEach(term => {
            const index = content.toLowerCase().indexOf(term.toLowerCase());
            if (index !== -1) {
                bestIndex = index;
            }
        });
        
        let excerpt = '';
        
        if (bestIndex !== -1) {
            // 以匹配词为中心截取内容
            const start = Math.max(0, bestIndex - length/2);
            const end = Math.min(content.length, bestIndex + terms[0].length + length/2);
            excerpt = content.substring(start, end);
            
            // 添加省略号
            if (start > 0) excerpt = '...' + excerpt;
            if (end < content.length) excerpt += '...';
        } else {
            // 没有匹配词时截取开头
            excerpt = content.substring(0, length);
            if (content.length > length) excerpt += '...';
        }
        
        // 高亮所有查询词
        return highlightText(excerpt, terms);
    }
    
    // 转义正则特殊字符
    function escapeRegExp(string) {
        return string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    }
    
    // 事件监听
    searchButton.addEventListener('click', performSearch);
    searchInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            performSearch();
        }
    });
    
    // 实时搜索
    let searchTimeout;
    searchInput.addEventListener('input', function() {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(performSearch, 500);
    });
});
</script>
