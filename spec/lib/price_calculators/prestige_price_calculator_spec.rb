require 'spec_helper'
require 'price_calculators/prestige_price_calculator'

describe PriceCalculators::PrestigePriceCalculator do
  before(:each) do
    rss_item = double
    rss = double

    allow(rss_item).to receive(:pubDate).and_return Time.now
    allow(rss).to receive(:items).and_return [rss_item, rss_item]
    allow(ContentParsers::RSSParser).to receive(:get_content).and_return(rss)
  end

  it 'calculates .margin as a number of pubDate element occurrences in rss feed' do
    expect(PriceCalculators::PrestigePriceCalculator.margin).to eq(2)
  end

  it 'calculates total_price as a : base + margin' do
    ppc = PriceCalculators::PrestigePriceCalculator.new(100)
    expect(ppc.total_price).to eq(102)

    ppc2 = PriceCalculators::PrestigePriceCalculator.new(0)
    expect(ppc2.total_price).to eq(2)
  end

  it 'cachces the margin calculation' do
    rss_new = double
    allow(rss_new).to receive(:items).and_return []
    allow(ContentParsers::RSSParser).to receive(:get_content).and_return(rss_new)

    fpc = PriceCalculators::PrestigePriceCalculator.new(100)
    expect(fpc.total_price).to eq(102) # without caching it should be 100
  end
end
