require 'spec_helper'
require 'price_calculators/flexible_price_calculator'

describe PriceCalculators::FlexiblePriceCalculator do
  before(:each) do
    allow(ContentParsers::HTMLParser).to receive(:get_content).and_return("#{['a'] * 320}")
  end

  it 'calculates .margin as a number of a occurrences on reuters page/100' do
    expect(PriceCalculators::FlexiblePriceCalculator.margin).to eq(3)
  end

  it 'calculates total_price as a : base * margin' do
    fpc = PriceCalculators::FlexiblePriceCalculator.new(100)
    expect(fpc.total_price).to eq(300)

    fpc2 = PriceCalculators::FlexiblePriceCalculator.new(1)
    expect(fpc2.total_price).to eq(3)
  end

  it 'caches the margin calculation' do
    allow(ContentParsers::HTMLParser).to receive(:get_content).and_return('aa')
    fpc = PriceCalculators::FlexiblePriceCalculator.new(100)
    expect(fpc.total_price).to eq(300) # without caching it should be 100
  end
end
