FactoryGirl.define do
  factory :model_type do
    sequence(:name) { |n| "bmw_#{n}" }
    sequence(:model_type_slug) { |n| "slug_bmw_#{n}" }
    sequence(:model_type_code) { |n| "code_bmw_#{n}" }
    base_price 10_000
    model
  end
end
