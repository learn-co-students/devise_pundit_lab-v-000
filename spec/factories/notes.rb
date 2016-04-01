FactoryGirl.define do
  factory :note do
    content "this is a test note"
    visible_to "tom, steve, bob"
  end
end