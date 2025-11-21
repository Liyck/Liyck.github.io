# 运行方式：ruby generate_categories.rb
require 'fileutils'

categories = Dir.glob("_posts/*").map do |file|
  File.read(file).scan(/categories:\s*\[?(.*?)\]?/).flatten.map { |c| c.split(",") }.flatten.map(&:strip)
end.flatten.uniq

FileUtils.mkdir_p("categories")

categories.each do |cat|
  filename = "categories/#{cat}.md"
  File.open(filename, "w") do |f|
    f.puts "---"
    f.puts "layout: category"
    f.puts "category: #{cat}"
    f.puts "permalink: /categories/#{cat}/"
    f.puts "---"
  end
end

puts "分类页面生成完毕！"
