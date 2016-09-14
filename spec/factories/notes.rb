FactoryGirl.define do
  factory :note do
    content "content for the note"

     trait :admin do
      role 'admin'
    end
    
     trait :moderator do
      role 'moderator'
    end
  end
end
