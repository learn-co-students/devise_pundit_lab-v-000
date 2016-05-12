FactoryGirl.define do
  factory :note do
    content "content"
    association :user

    trait :visible_to do
      visible_to "TestUser22"
    end
  end
end