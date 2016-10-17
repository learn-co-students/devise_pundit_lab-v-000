include Warden::Test::Helpers
Warden.test_mode!

# Feature: User delete
#   As a user
#   I want to my note
feature 'Note delete', :devise, :js do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User can delete own notes
  #   Given I am signed in
  #   When I delete my notes
  #   Then I should see an account deleted message
  # scenario 'user can delete their own notes' do
  #   skip 'skip a slow test'
  #   user = FactoryGirl.create(:user)
  #   login_as(user, :scope => :user)
  #   visit edit_user_registration_path(user)
  #   click_button 'Cancel my account'
  #   page.driver.browser.switch_to.alert.accept
  #   expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  # end

  # scenario 'user cannot delete other notes' do
  #   skip 'skip a slow test'
  #   user = FactoryGirl.create(:user)
  #   login_as(user, :scope => :user)
  #   visit edit_user_registration_path(user)
  #   click_button 'Cancel my account'
  #   page.driver.browser.switch_to.alert.accept
  #   expect(page).to have_content I18n.t 'devise.registrations.destroyed'
  # end

end
