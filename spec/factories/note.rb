FactoryGirl.define do
  factory :note do
    created_at Time.now
    content "Test Content"
    user_id 1
  end
end
