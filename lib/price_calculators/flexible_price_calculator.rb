module PriceCalculators
  class FlexiblePriceCalculator < PriceCalculators::CommonPriceCalculator
    URL = 'http://reuters.com'

    def self.margin
      content = ContentParsers::HTMLParser.get_content(URL)
      (content.count('a') / 100.to_f).round
    end

    def total_price
      cached_margin * @base_price
    end
  end
end
