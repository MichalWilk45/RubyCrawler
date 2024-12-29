require "nokogiri"
require "httparty"

class Crawler
    BASE_URL = "https://www.empik.com/szukaj/produkt?q="
    def initialize(keyword)
    @url = "#{BASE_URL}#{keyword}"
  end

  def fetch_page()
    response = HTTParty.get(@url)
    Nokogiri::HTML(response.body)
  end
  def parse_products(page)
    products = page.css(".search-list-item") # Główne kontenery produktów
    products.map do |product|
      {
        title: product.at_css(".ta-product-title")&.text&.strip,
        price: product.at_css(".price")&.text&.strip
      }
    end
  end
end
crawler = Crawler.new("laptop macbook")
page = crawler.fetch_page
products = crawler.parse_products(page)

puts "Znaleziono produkty:"
products.each_with_index do |product, index|
  puts "#{index + 1}. #{product[:title]} - #{product[:price]}"
end