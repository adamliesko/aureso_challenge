require 'rails_helper'

RSpec.describe 'models/organization_models.json.jbuilder' do
  it 'renders model_type with total_price' do
    m1 = FactoryGirl.create(:model)
    m2 = FactoryGirl.create(:model)
    FactoryGirl.create(:model_type, model: m1)
    FactoryGirl.create(:model_type, model: m2)
    assign(:models, [m1.reload, m2.reload])

    render

    response_hash = JSON.parse(rendered)
    expect(response_hash).to eq ({ 'models' => [{ 'name' => 'Series 18', 'model_types' => [{ 'name' => 'bmw_12', 'total_price' => 10_002 }] }, { 'name' => 'Series 19', 'model_types' => [{ 'name' => 'bmw_13', 'total_price' => 10_002 }] }] })
  end
end
