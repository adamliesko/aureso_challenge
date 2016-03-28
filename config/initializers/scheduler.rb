require 'rufus-scheduler'

s = Rufus::Scheduler.singleton

s.every '1h' do
  PriceCalculators::CommonPriceCalculator.update_cached_values
end
