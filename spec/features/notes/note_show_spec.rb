include Warden::Test::Helpers
Warden.test_mode!

# Feature: User profile page
#   As a user
#   I want to visit my note page

feature 'Note page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User sees own profile
  #   Given I am signed in
  #   When I visit the user profile page
  #   Then I see my own email address
  scenario 'user sees own profile' do
    user = FactoryGirl.create(:user)
    note = FactoryGirl.create(:note)
    login_as(user, :scope => :user)
    visit note_path(note)
    expect(page).to have_content 'Note'
    expect(page).to have_content note.content
  end

  # Scenario: User cannot see another user's profile
  #   Given I am signed in
  #   When I visit another user's profile
  #   Then I see an 'access denied' message
  # scenario "user cannot see another user's profile" do
  #   note = FactoryGirl.create(:note)
  #   me = FactoryGirl.create(:user)
  #   other = FactoryGirl.create(:user, email: 'other@example.com')
  #   note.user = other
  #   login_as(me, :scope => :user)
  #   Capybara.current_session.driver.header 'Referer', root_path
  #   visit note_path(note)
  #   expect(page).to have_content 'Access denied.'
  # end

end
