FactoryGirl.define do
  factory :note do
    content "Test Note"
    association :user
  end
end
