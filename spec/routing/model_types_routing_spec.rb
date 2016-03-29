require 'rails_helper'

RSpec.describe ModelTypesController, type: :routing do
  it 'is invalid without name' do
    expect(post: 'models/slug1/model_types_price/slug2').to route_to(
      controller: 'model_types',
      model_slug: 'slug1',
      model_type_slug: 'slug2',
      action: 'price', format: :json)
  end
end
