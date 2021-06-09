describe UserPolicy do
  subject { UserPolicy }

  let (:current_user) { FactoryBot.build_stubbed :user }
  let (:other_user) { FactoryBot.build_stubbed :user }
  let (:admin) { FactoryBot.create(:user, email: 'other@example.com') }
#factorybot was not creating users with valid roles, roles were nil so tests weren't working 

end
