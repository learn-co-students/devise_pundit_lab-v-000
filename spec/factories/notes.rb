FactoryGirl.define do
  factory :note do
    content "Test content!!"
    visible_to "test@example.com"
    user
  end
end
