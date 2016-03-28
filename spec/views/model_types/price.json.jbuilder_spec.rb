require 'rails_helper'

RSpec.describe 'model_types/price.json.jbuilder' do
  it 'renders model_type with total_price' do
    mt = FactoryGirl.build(:model_type)
    assign(:model_type, mt)
    allow_any_instance_of("PriceCalculators::#{mt.model.organization.pricing_policy}PriceCalculator".constantize).to receive(:total_price).and_return(10_500)

    render

    response_hash = JSON.parse(rendered)

    expect(response_hash).to eq ({ 'model_type' => { 'name' => 'bmw_11', 'base_price' => 10_000, 'total_price' => 10_500 } })
  end
end
