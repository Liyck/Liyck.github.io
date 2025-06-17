---
layout: page
title: 搜索
permalink: /search/
---

<div class="search-container">
  <div class="search-header">
    <h1>探索知识宝库</h1>
    <p>输入关键词，发现您感兴趣的内容</p>
  </div>
  
  <div class="search-box">
    <div class="search-input-container">
      <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
        <path fill="currentColor" d="M15.5 14h-.79l-.28-.27A6.471 6.471 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/>
      </svg>
      <input type="text" id="search-input" placeholder="输入关键词搜索文章..." autocomplete="off" />
      <button type="button" id="search-button">
        <span>搜索</span>
        <svg class="search-arrow" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20">
          <path fill="currentColor" d="M12 4l-1.41 1.41L16.17 11H4v2h12.17l-5.58 5.59L12 20l8-8z"/>
        </svg>
      </button>
    </div>
  </div>
  
  <div class="search-results-container">
    <div id="search-loading" class="search-status">
      <div class="spinner"></div>
      <span>正在搜索...</span>
    </div>
    
    <div id="no-results" class="search-status">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="48" height="48">
        <path fill="none" d="M0 0h24v24H0z"/>
        <path fill="#6c757d" d="M15.5 14h-.79l-.28-.27A6.471 6.471 0 0 0 16 9.5 6.5 6.5 0 1 0 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/>
        <path fill="#6c757d" d="M12 10.9c-.61 0-1.1.49-1.1 1.1s.49 1.1 1.1 1.1 1.1-.49 1.1-1.1-.49-1.1-1.1-1.1z"/>
      </svg>
      <h3>未找到相关结果</h3>
      <p>尝试使用不同的关键词进行搜索</p>
    </div>
    
    <div id="search-results"></div>
  </div>
</div>

<style>
:root {
  --primary-color: #3a86ff;
  --primary-hover: #2667cc;
  --text-color: #333;
  --text-light: #666;
  --text-lighter: #888;
  --background: #f8f9fa;
  --card-bg: #fff;
  --border-color: #e1e5e9;
  --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  --radius: 12px;
  --transition: all 0.3s ease;
}

.search-container {
  max-width: 800px;
  margin: 0 auto;
  padding: 40px 20px;
}

.search-header {
  text-align: center;
  margin-bottom: 40px;
}

.search-header h1 {
  font-size: 2.5rem;
  margin-bottom: 12px;
  color: var(--text-color);
  font-weight: 700;
}

.search-header p {
  font-size: 1.1rem;
  color: var(--text-light);
  max-width: 600px;
  margin: 0 auto;
  line-height: 1.6;
}

.search-box {
  margin-bottom: 40px;
}

.search-input-container {
  position: relative;
  display: flex;
  border-radius: var(--radius);
  background: var(--card-bg);
  box-shadow: var(--shadow);
  overflow: hidden;
  border: 1px solid var(--border-color);
  transition: var(--transition);
  height: 48px; /* 固定高度，保证输入框和按钮高度一致 */
}

.search-input-container:focus-within {
  border-color: var(--primary-color);
  box-shadow: 0 0 0 3px rgba(58, 134, 255, 0.2);
}

.search-icon {
  position: absolute;
  left: 16px;
  top: 50%;
  transform: translateY(-50%);
  color: var(--text-lighter);
  z-index: 1;
  width: 24px;
  height: 24px;
}

#search-input {
  flex: 1;
  padding: 0 20px 0 56px;
  border: none;
  font-size: 1.1rem;
  background: transparent;
  color: var(--text-color);
  height: 100%;
  line-height: 48px;
}

#search-input::placeholder {
  color: var(--text-lighter);
}

#search-input:focus {
  outline: none;
}

#search-button {
  display: flex;
  align-items: center;
  padding: 0 24px;
  background-color: var(--primary-color);
  color: white;
  border: none;
  cursor: pointer;
  font-size: 1.1rem;
  font-weight: 600;
  transition: var(--transition);
  height: 100%;
}

#search-button:hover {
  background-color: var(--primary-hover);
}

#search-button .search-arrow {
  margin-left: 8px;
  transition: transform 0.3s ease;
}

#search-button:hover .search-arrow {
  transform: translateX(3px);
}

.search-results-container {
  position: relative;
  min-height: 300px;
}

.search-status {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 40px 20px;
  border-radius: var(--radius);
  background: var(--card-bg);
  box-shadow: var(--shadow);
}

#search-loading,
#no-results {
  display: none;
}

#no-results svg {
  margin-bottom: 20px;
}

#no-results h3 {
  margin: 0 0 10px 0;
  color: var(--text-color);
}

#no-results p {
  color: var(--text-light);
  margin: 0;
}

.spinner {
  width: 50px;
  height: 50px;
  border: 4px solid rgba(58, 134, 255, 0.2);
  border-top: 4px solid var(--primary-color);
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 20px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.search-result {
  margin-bottom: 25px;
  padding: 25px;
  border-radius: var(--radius);
  background: var(--card-bg);
  box-shadow: var(--shadow);
  transition: var(--transition);
  border-left: 4px solid transparent;
}

.search-result:hover {
  transform: translateY(-3px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
  border-left: 4px solid var(--primary-color);
}

.search-result h3 {
  margin: 0 0 12px 0;
  font-size: 1.4rem;
}

.search-result h3 a {
  color: var(--text-color);
  text-decoration: none;
  transition: var(--transition);
  display: inline-block;
}

.search-result h3 a:hover {
  color: var(--primary-color);
}

.search-result .meta {
  display: flex;
  align-items: center;
  color: var(--text-light);
  font-size: 0.95rem;
  margin-bottom: 15px;
}

.search-result .meta::before {
  content: "•";
  margin: 0 10px;
}

.search-result .meta div:first-child::before {
  content: none;
}

.search-result .excerpt {
  color: var(--text-light);
  line-height: 1.7;
  margin-bottom: 0;
}

mark {
  background-color: #fffd54;
  padding: 0 4px;
  border-radius: 4px;
  font-weight: 600;
}

.results-count {
  font-size: 1.1rem;
  color: var(--text-light);
  margin-bottom: 25px;
  padding-bottom: 15px;
  border-bottom: 1px solid var(--border-color);
}

@media (max-width: 768px) {
  .search-container {
    padding: 20px 15px;
  }
  
  .search-header h1 {
    font-size: 2rem;
  }
  
  .search-input-container {
    flex-direction: column;
    height: auto;
  }
  
  #search-input {
    padding: 12px 20px 12px 56px;
    line-height: normal;
    height: 48px;
  }
  
  #search-button {
    width: 100%;
    padding: 12px 0;
    margin-top: 8px;
    height: 48px;
    justify-content: center;
  }
  
  .search-result {
    padding: 20px;
  }
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
    fetch('/search.json')
        .then(response => response.json())
        .then(data => {
            searchData = data;
            console.log('搜索数据已加载，文章数量:', data.length);
        })
        .catch(error => {
            console.error('加载搜索数据失败:', error);
            showError('加载搜索数据失败，请刷新页面重试');
        });
    
    // 搜索函数
    function performSearch() {
        const query = searchInput.value.trim().toLowerCase();
        
        if (query.length === 0) {
            searchResults.innerHTML = '';
            noResults.style.display = 'none';
            return;
        }
        
        searchLoading.style.display = 'flex';
        noResults.style.display = 'none';
        searchResults.innerHTML = '';
        
        setTimeout(() => {
            try {
                const results = searchData.filter(post => {
                    return post.title.toLowerCase().includes(query) ||
                           post.content.toLowerCase().includes(query);
                });
                
                searchLoading.style.display = 'none';
                
                if (results.length === 0) {
                    noResults.style.display = 'flex';
                } else {
                    displayResults(results, query);
                }
            } catch (error) {
                console.error('搜索过程中出错:', error);
                showError('搜索过程中发生错误');
                searchLoading.style.display = 'none';
            }
        }, 300);
    }
    
    // 显示搜索结果
    function displayResults(results, query) {
        const resultsHtml = results.map(post => {
            const highlightedTitle = highlightText(post.title, query);
            const excerpt = generateExcerpt(post.content, query);
            
            return `
                <div class="search-result">
                    <h3><a href="${post.url}">${highlightedTitle}</a></h3>
                    <div class="meta">
                        <div>发布于 ${post.date}</div>
                    </div>
                    <div class="excerpt">${excerpt}</div>
                </div>
            `;
        }).join('');
        
        searchResults.innerHTML = `
            <div class="results-count">
                找到 ${results.length} 个与 "<mark>${query}</mark>" 相关的结果
            </div>
            ${resultsHtml}
        `;
    }
    
    // 高亮匹配文本
    function highlightText(text, query) {
        if (!query) return text;
        
        const regex = new RegExp(`(${escapeRegExp(query)})`, 'gi');
        return text.replace(regex, '<mark>$1</mark>');
    }
    
    // 生成包含关键词的摘要
    function generateExcerpt(content, query, length = 200) {
        if (!query) {
            return content.substring(0, length) + (content.length > length ? '...' : '');
        }
        
        const index = content.toLowerCase().indexOf(query.toLowerCase());
        
        if (index === -1) {
            return content.substring(0, length) + (content.length > length ? '...' : '');
        }
        
        const start = Math.max(0, index - length / 2);
        const end = Math.min(content.length, index + query.length + length / 2);
        
        let excerpt = content.substring(start, end);
        
        if (start > 0) excerpt = '...' + excerpt;
        if (end < content.length) excerpt += '...';
        
        return highlightText(excerpt, query);
    }
    
    // 转义正则特殊字符
    function escapeRegExp(string) {
        return string.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    }
    
    // 显示错误信息
    function showError(message) {
        searchResults.innerHTML = `
            <div class="search-status">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="48" height="48">
                    <path fill="none" d="M0 0h24v24H0z"/>
                    <path fill="#dc3545" d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/>
                </svg>
                <h3>出错了</h3>
                <p>${message}</p>
            </div>
        `;
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
    
    // 自动聚焦搜索框
    searchInput.focus();
});
</script>
