require 'rails_helper'

RSpec.describe 'models/organization_models.json.jbuilder' do
  it 'renders model_type with total_price' do
    m1 = FactoryGirl.create(:model)
    m2 = FactoryGirl.create(:model)
    mt1 = FactoryGirl.create(:model_type, model: m1)
    mt2 = FactoryGirl.create(:model_type, model: m2)
    assign(:models, [m1.reload, m2.reload])
    allow_any_instance_of("PriceCalculators::#{m1.organization.pricing_policy}PriceCalculator".constantize).to receive(:total_price).and_return(10_500)

    render

    response_hash = JSON.parse(rendered)
    expect(response_hash).to eq ({ 'models' => [{ 'name' => m1.name, 'model_types' => [{ 'name' => mt1.name, 'total_price' => 10_500 }] }, { 'name' => m2.name, 'model_types' => [{ 'name' => mt2.name, 'total_price' => 10_500 }] }] })
  end
end
