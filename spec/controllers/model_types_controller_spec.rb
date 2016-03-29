require 'rails_helper'

RSpec.describe ModelTypesController, type: :controller do
  before :each do
    request.accept = 'application/json'
  end

  describe 'POST #price - calculates total price from a base price. Authorization required.' do
    context 'without valid auth_token'do
      it 'returns 403 Unauthorized Error' do
        model_type = FactoryGirl.create(:model_type)
        request.env['HTTP_AUTHORIZATION'] = 'no-goood'

        post :price, model_slug: model_type.model.model_slug, model_type_slug: model_type.model_type_slug, base_price: 25_000

        expect(JSON.load response.body).to eq ({ 'message' => 'Unauthorized access' })
        expect(response.status).to eq 401
      end
    end

    context 'with valid auth_token' do
      it 'calculates total_price of a model type and returns it as json' do
        model_type = FactoryGirl.create(:model_type)
        org = model_type.model.organization
        request.env['HTTP_AUTHORIZATION'] = org.auth_token

        post :price, model_slug: model_type.model.model_slug, model_type_slug: model_type.model_type_slug, base_price: 25_000
        expect(assigns(:model_type)).to eq(model_type)
        expect(response.status).to eq 200
      end

      it 'returns 404 not found on non-existent model type' do
        model_type = FactoryGirl.create(:model_type)
        org = model_type.model.organization
        request.env['HTTP_AUTHORIZATION'] = org.auth_token

        post :price, model_slug: 'sluuugfake_fake', model_type_slug: 'sluuugfake', base_price: 25_000

        expect(response.status).to eq 404
        expect(JSON.load(response.body)).to eq ({ 'message' => '404 - Not Found' })
      end
    end
  end
end
