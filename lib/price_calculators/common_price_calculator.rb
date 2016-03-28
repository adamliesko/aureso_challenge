module PriceCalculators
  class CommonPriceCalculator
    attr_reader :base_price

    CALCULATORS = [PriceCalculators::FixedPriceCalculator, PriceCalculators::FlexiblePriceCalculator, PriceCalculators::PrestigePriceCalculator]

    def initialize(base_price)
      @base_price = base_price
    end

    def self.margin
      fail NotImplementedError
    end

    def total_price
      fail NotImplementedError
    end

    def cached_margin
      @@cached_margins ||= {}
      @@cached_margins[self.class] ||= self.class.margin
      @@cached_margins[self.class]
    end

    def self.clear_cache
      @@cached_margins = {}
    end

    def self.update_cached_values(price_calcs_to_update = CALCULATORS)
      @@cached_margins = {}
      Rails.logger.info "Updating PriceCalculators:Common.update_cached_values: #{price_calcs_to_update}"

      price_calcs_to_update.each do |pricing|
        @@cached_margins[pricing] = pricing.margin
      end
    end
  end
end
