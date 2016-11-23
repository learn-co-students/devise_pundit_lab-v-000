FactoryGirl.define do
  factory :note do
    content "Some content"

    factory :note_with_user do
      user
    end
  end
end
