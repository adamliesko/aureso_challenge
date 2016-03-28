module PriceCalculators
  class PrestigePriceCalculator < PriceCalculators::CommonPriceCalculator
    URL = 'http://www.yourlocalguardian.co.uk/sport/rugby/rss/'

    def self.margin
      content = ContentParsers::RSSParser.get_content(URL)
      content.items.inject(0) do |count, item|
        count += 1 if item.respond_to? 'pubDate'
      end
    end

    def total_price
      cached_margin + @base_price
    end
  end
end
