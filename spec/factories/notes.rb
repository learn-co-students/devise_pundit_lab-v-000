FactoryGirl.define do
  factory :note do
    confirmed_at Time.now
    content "My Note"
  end

  factory :unshared_note, parent: :note do
    user_id 1
  end

  factory :shared_note, parent: :note do
    user_id 1
    after(:create) do |shared_note|
      shared_note.viewers << User.all
    end
  end

end
