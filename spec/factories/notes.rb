FactoryGirl.define do |variable|
	factory :note do
		content "Test content"

		trait :admin do
			role 'admin'
		end
	end			
end