require 'rails_helper'

RSpec.describe ModelsController, type: :controller do
  before :each do
    request.accept = 'application/json'
  end

  describe 'GET #organization_models responds with models belonging to the organization. Authorization required.' do
    context 'without valid auth_token'do
      it 'returns 403 Unauthorized Error' do
        request.env['HTTP_AUTHORIZATION'] = 'no-goood'

        get :organization_models, model_slug: 'fakeslug'

        expect(JSON.load response.body).to eq ({ 'message' => 'Unauthorized access' })
        expect(response.status).to eq 401
      end
    end

    context 'with valid auth_token'do
      it 'returns list of models/model_types matching model_slug with their respective total_price calculated by pricing policy of org' do
        org = FactoryGirl.create(:organization)
        m1 = FactoryGirl.create(:model, organization: org)

        mt1 = FactoryGirl.create(:model_type, model: m1)
        mt2 = FactoryGirl.create(:model_type, model: m1)

        request.env['HTTP_AUTHORIZATION'] = org.auth_token

        get :organization_models, model_slug: m1.model_slug

        expect(assigns(:models)).to eq([m1])
        expect(response.status).to eq 200
      end
    end
  end
end
