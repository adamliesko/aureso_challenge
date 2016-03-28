FactoryGirl.define do
  factory :organization do
    sequence(:name) { |n| "Example Name #{n}" }
    sequence(:public_name) { |n| "Example public name #{n}" }
    auth_token 'testing_auth_token'
    pricing_policy 'Fixed'
  end

  factory :dealer, class: Dealer, parent: :organization do
  end

  factory :show_room, class: ShowRoom, parent: :organization do
  end

  factory :service, class: Service, parent: :organization do
  end

  trait :flexible do
    pricing_policy 'Flexible'
  end

  trait :fixed do
    pricing_policy 'Fixed'
  end

  trait :prestige do
    pricing_policy 'Prestige'
  end
end
