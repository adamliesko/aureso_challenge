require 'spec_helper'
require 'price_calculators/common_price_calculator'

describe PriceCalculators::CommonPriceCalculator do
  after(:each) do
    PriceCalculators::CommonPriceCalculator.clear_cache
  end

  it 'updates cached values with new values when no previous values are present' do
    stub_parsers

    PriceCalculators::CommonPriceCalculator.clear_cache
    PriceCalculators::CommonPriceCalculator.update_cached_values
    expect(PriceCalculators::FlexiblePriceCalculator.margin).to eq(0)
    expect(PriceCalculators::FixedPriceCalculator.margin).to eq(2)
    expect(PriceCalculators::PrestigePriceCalculator.margin).to eq(2)
  end

  it 'updates cached values with new values when previous values are present (overwrites them)' do
    stub_parsers

    PriceCalculators::CommonPriceCalculator.update_cached_values
    allow(ContentParsers::HTMLParser).to receive(:get_content).and_return('status status a status status') #change parser outcome
    PriceCalculators::CommonPriceCalculator.update_cached_values

    expect(PriceCalculators::FixedPriceCalculator.margin).to eq(4)
  end

  it 'raises an error on .margin call' do
    expect { PriceCalculators::CommonPriceCalculator.margin }.to raise_error(NotImplementedError)
  end

  it 'raises an error on #total_price call' do
    cpc = PriceCalculators::CommonPriceCalculator.new(10)
    expect { cpc.total_price }.to raise_error(NotImplementedError)
  end

  def stub_parsers
    rss_item = double
    rss = double

    allow(rss_item).to receive(:pubDate).and_return Time.now
    allow(rss).to receive(:items).and_return [rss_item, rss_item]
    allow(ContentParsers::RSSParser).to receive(:get_content).and_return(rss)
    allow(ContentParsers::HTMLParser).to receive(:get_content).and_return('status status a')
  end
end
