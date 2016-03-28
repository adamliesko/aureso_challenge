require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { should have_many(:models) }

  it 'is invalid without name' do
    org = FactoryGirl.build(:organization, name: nil)

    expect { org.save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect(org.errors.messages[:name]).to eq(["can't be blank"])
  end

  it 'is invalid without public_name' do
    org = FactoryGirl.build(:organization, public_name: nil)

    expect { org.save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect(org.errors.messages[:public_name]).to eq(["can't be blank"])
  end

  it 'checks pricing policy to be present and be one of [Flexible Fixed Prestige]' do
    org = FactoryGirl.build(:organization, pricing_policy: 'Sticky')

    expect { org.save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect(org.errors.messages[:pricing_policy]).to eq(['Sticky is not a valid pricing policy'])

    org.pricing_policy = nil

    expect { org.save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect(org.errors.messages[:pricing_policy]).to eq(["can't be blank", ' is not a valid pricing policy'])
  end

  it 'sets its auth token before creation' do
    org = Organization.new(name: 'Org. name', public_name: 'Public name', pricing_policy: 'Flexible')
    expect(org.auth_token).to be_nil

    org.save
    expect(org.auth_token.blank?).to be_falsy
  end

  it ' verifies that auth_token is unique' do
    org1 = FactoryGirl.create(:organization)
    org2 = FactoryGirl.build(:organization, auth_token: org1.auth_token)
    expect { org2.save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect(org2.errors.messages[:auth_token]).to eq(['has already been taken'])
  end

  it 'can filters organization models with certain slug' do
    org1 = FactoryGirl.create(:organization)
    model1 = FactoryGirl.create(:model, organization: org1)
    FactoryGirl.create(:model, organization: org1)
    FactoryGirl.create(:model, organization: org1)

    expect(org1.models_with_slug(model1.model_slug)).to eq([model1])
  end
end
