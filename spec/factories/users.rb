FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    sequence(:name) {|n| "Test User#{n}" } 
    sequence(:email) {|n| "Test_user#{n}@example.com" } 
    password "please123"

    trait :admin do
      role 'admin'
    end

    trait :vip do
      role 'vip'
    end

  end
end
