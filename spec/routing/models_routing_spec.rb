require 'rails_helper'

RSpec.describe ModelsController, type: :routing do
  it 'is invalid without name' do
    expect(get: 'models/slug1/model_types').to route_to(
      controller: 'models',
      model_slug: 'slug1',
      action: 'organization_models', format: :json)
  end
end
