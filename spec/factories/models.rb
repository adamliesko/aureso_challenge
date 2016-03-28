FactoryGirl.define do
  factory :model do
    sequence(:name) { |n| "Series #{n}" }
    sequence(:model_slug) { |n| "slug_series_#{n}" }
    organization
  end
end
