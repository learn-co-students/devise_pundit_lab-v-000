include Warden::Test::Helpers
Warden.test_mode!

# Feature: User index page
#   As an ADMIN only, right? not just user.
#   I want to see a list of users
#   So I can see who has registered
#   
#   This is unclear in the test. Is the index page for users to see everyone, or for admins?
feature 'User index page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User listed on index page
  #   Given I am signed in
  #   When I visit the user index page
  #   Then I see my own email address
  scenario 'user sees own email address' do
    user = FactoryGirl.create(:user, :admin)
    #So a user here is an admin, not just a low-permission user...
    login_as(user, scope: :user)
    visit users_path
    expect(page).to have_content user.email
  end

end
