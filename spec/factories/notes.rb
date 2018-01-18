FactoryGirl.define do
  factory :note do
    content "First test note"

    trait :user_owner do
      association :user
    end

    trait :other_owner do
      user_id 2
    end
  end
end