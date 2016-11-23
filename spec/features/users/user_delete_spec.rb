

# Feature: User delete
#   As a user
#   I want to delete my user profile
#   So I can close my account
feature 'User delete', :devise do

  # Scenario: User can delete own account
  #   Given I am signed in
  #   When I delete my account
  #   Then I should see an account deleted message
  scenario 'user can delete own account' do
    # I made some changes to this test because I was having problems with selenium
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    visit edit_user_registration_path(user)
    click_button 'Cancel my account'
    expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  end

end
