require 'spec_helper'
require 'price_calculators/common_price_calculator'

describe PriceCalculators::CommonPriceCalculator do
  it 'updates cached values with new values when no previous values are present' do
    rss_item = double
    rss = double

    allow(rss_item).to receive(:pubDate).and_return Time.now
    allow(rss).to receive(:items).and_return [rss_item, rss_item]
    allow(ContentParsers::RSSParser).to receive(:get_content).and_return(rss)
    allow(ContentParsers::HTMLParser).to receive(:get_content).and_return('status a')

    PriceCalculators::CommonPriceCalculator.clear_cache
    PriceCalculators::CommonPriceCalculator.update_cached_values([PriceCalculators::FixedPriceCalculator])

    expect(PriceCalculators::FlexibleCalculator.margin).to eq(2)
    expect(PriceCalculators::FixedCalculator.margin).to eq(1)
    expect(PriceCalculators::PrestigeCalculator.margin).to eq(2)
  end

  it 'updates cached values with new values and overwrites existing values' do
    PriceCalculators::CommonPriceCalculator.update_cached_values
    PriceCalculators::CommonPriceCalculator.update_cached_values
  end

  it 'raises an error on .margin call' do
    expect { PriceCalculators::CommonPriceCalculator.margin }.to raise_error(NotImplementedError)
  end

  it 'raises an error on #total_price call' do
    cpc = PriceCalculators::CommonPriceCalculator.new(10)
    expect { cpc.total_price }.to raise_error(NotImplementedError)
  end
end
