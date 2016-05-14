FactoryGirl.define do
  factory :note do
    content "content"
    association :user
  end
end