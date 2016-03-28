require 'spec_helper'
require 'price_calculators/fixed_price_calculator'

describe PriceCalculators::FixedPriceCalculator do
  before(:each) do
    allow(ContentParsers::HTMLParser).to receive(:get_content).and_return('status one two three status')
  end

  it 'calculates .margin as a number of string status occurrences on a github page' do
    expect(PriceCalculators::FixedPriceCalculator.margin).to eq(2)
  end

  it 'calculates total_price as a : base + margin' do
    fpc = PriceCalculators::FixedPriceCalculator.new(100)
    expect(fpc.total_price).to eq(102)
  end

  it 'caches the margin calculation' do
    allow(ContentParsers::HTMLParser).to receive(:get_content).and_return('status status status one two three status')
    fpc = PriceCalculators::FixedPriceCalculator.new(100)
    expect(fpc.total_price).to eq(102) # without caching it should be 104
  end
end
