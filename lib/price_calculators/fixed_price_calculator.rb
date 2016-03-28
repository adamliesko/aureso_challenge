module PriceCalculators
  class FixedPriceCalculator < PriceCalculators::CommonPriceCalculator
    URL = 'https://developer.github.com/v3/#http-redirects'

    def self.margin
      content = ContentParsers::HTMLParser.get_content(URL)
      content.scan(/status/).count
    end

    def total_price
      cached_margin + @base_price
    end
  end
end
