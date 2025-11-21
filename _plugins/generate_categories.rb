require 'fileutils'
require 'uri'

module Jekyll
  class CategorySlug
    # 将中文分类名转换为英文 slug
    def self.slugify(name)
      # 替换空格
      name = name.strip.gsub(/\s+/, "-")

      # 如果有中文，则转拼音（简易方案）
      # 避免依赖 gem：仅处理英文和数字，其余转 utf8-safe hex
      slug = name.each_char.map do |char|
        if char =~ /[A-Za-z0-9\-]/
          char
        else
          # 中文 -> hex，例如 "技术" → e6-8a-80-e6-9c-af
          char.bytes.map { |b| "%02x" % b }.join
        end
      end.join

      slug.downcase
    end
  end

  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      site.categories.each do |category, posts|
        slug = CategorySlug.slugify(category)
        site.pages << CategoryPage.new(site, site.source, category, slug)
      end
    end
  end

  class CategoryPage < Page
    def initialize(site, base, category, slug)
      @site = site
      @base = base
      @dir  = "categories/#{slug}"
      @name = "index.html"

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'category.html')

      self.data['title'] = category
      self.data['slug'] = slug
    end
  end
end
