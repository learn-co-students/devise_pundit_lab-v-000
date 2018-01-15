FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    name "Test User"
    email "test@example.com"
    password "please123"

    trait :admin do
      role 'admin'
    end

    trait :moderator do
      role 'moderator'
    end

    trait :another do
      name 'Another Test User'
      email "test2@example.com"
      password "please123"
    end

  end

end
