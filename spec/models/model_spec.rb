require 'rails_helper'

RSpec.describe Model, type: :model do
  it { should belong_to(:organization) }
  it { should have_many(:model_types) }

  it 'is invalid without name' do
    model = FactoryGirl.build(:model, name: nil)

    expect { model.save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect(model.errors.messages[:name]).to eq(["can't be blank"])
  end

  it 'is invalid without model_slug' do
    model = FactoryGirl.build(:model, model_slug: nil)

    expect { model.save! }.to raise_error(ActiveRecord::RecordInvalid)
    expect(model.errors.messages[:model_slug]).to eq(["can't be blank"])
  end

  context 'duplicate name or model slug' do
    it 'is invalid' do
      model1 = FactoryGirl.build(:model)
      model2 = FactoryGirl.build(:model, name: model1.name, model_slug: model1.model_slug)

      expect(model1.save!).to be_truthy
      expect { model2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(model2.errors.messages[:name]).to eq(['has already been taken'])
      expect(model2.errors.messages[:model_slug]).to eq(['has already been taken'])
    end
  end

  it 'filters models by their model_types_slug with :with_model_type_slug' do
    model1 = FactoryGirl.create(:model)
    model2 = FactoryGirl.create(:model)

    FactoryGirl.create(:model_type, model_type_slug: 'slug', model: model1)
    FactoryGirl.create(:model_type, model_type_slug: 'slug2', model: model2)
    FactoryGirl.create(:model_type, model_type_slug: 'slug_fake', model: model1)

    expect(Model.with_model_type_slug('slug')).to eq([model1])
    expect(Model.with_model_type_slug('slug2')).to eq([model2])
  end
end
