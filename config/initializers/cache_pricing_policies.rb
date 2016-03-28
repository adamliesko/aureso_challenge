unless Rails.env == 'test'
  require File.join(Rails.root, 'lib', 'price_calculators', 'common_price_calculator')

  PriceCalculators::CommonPriceCalculator.update_cached_values
end
