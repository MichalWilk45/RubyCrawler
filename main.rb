require_relative "lib/crawler"

crawler = Crawler.new("iphone")
page = crawler.fetch_page()
puts page.title

puts "Crawler started!"
