FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    name "Test User"
    email "test@example.com"
    password "please123"

    trait :admin do
      role 'admin'
    end

    trait :vip do
      role 'vip'
    end

    factory :other_user do
      confirmed_at Time.now
      name "Another"
      email "secondtest@test.com"
      password "passwordy"
    end

  end
end
