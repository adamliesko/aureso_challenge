require 'rails_helper'

RSpec.describe ModelType, type: :model_type do
  it { should belong_to(:model) }

  it 'is invalid without name' do
    model_type = FactoryGirl.build(:model_type, name: nil)

    expect { model_type.save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect(model_type.errors.messages[:name]).to eq(["can't be blank"])
  end

  it 'is invalid without model_type_slug' do
    model = FactoryGirl.build(:model_type, model_type_slug: nil)

    expect { model.save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect(model.errors.messages[:model_type_slug]).to eq(["can't be blank"])
  end

  context 'duplicate name, model_type_code or  model_type_slug' do
    it 'is invalid' do
      model_type1 = FactoryGirl.build(:model_type)
      model_type2 = FactoryGirl.build(:model_type, name: model_type1.name, model_type_slug: model_type1.model_type_slug, model_type_code: model_type1.model_type_code)

      expect(model_type1.save!).to be_truthy
      expect { model_type2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(model_type2.errors.messages[:name]).to eq(['has already been taken'])
      expect(model_type2.errors.messages[:model_type_slug]).to eq(['has already been taken'])
      expect(model_type2.errors.messages[:model_type_code]).to eq(['has already been taken'])
    end
  end

  it 'calculates total_price through model.organization Pricing Policy' do
    model_type = FactoryGirl.build(:model_type)
    org_pricing_policy = model_type.model.organization.pricing_policy

    allow_any_instance_of('PriceCalculators::PrestigePriceCalculator'.constantize).to receive(:total_price).and_return(99_500)
    allow_any_instance_of("PriceCalculators::#{org_pricing_policy}PriceCalculator".constantize).to receive(:total_price).and_return(10_500)
    expect(model_type.total_price).to eq(10_500)
  end

  it 'calculates custom price from custom base price for an organization model type with a certain model slug and model type slug' do
    model_type = FactoryGirl.create(:model_type)
    org_pricing_policy = model_type.model.organization.pricing_policy
    allow_any_instance_of("PriceCalculators::#{org_pricing_policy}PriceCalculator".constantize).to receive(:total_price).and_return(10_500)

    mt = ModelType.with_custom_price(model_type.model.organization, base_price: 10, model_slug: model_type.model.model_slug, model_type_slug: model_type.model_type_slug)
    expect(mt.total_price).to eq(10_500)
  end
end
