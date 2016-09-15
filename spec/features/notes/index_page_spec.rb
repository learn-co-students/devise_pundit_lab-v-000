include Warden::Test::Helpers
Warden.test_mode!

# Feature: User index page
#   As a user
#   I want to see a list of users
#   So I can see who has registered
feature 'Note index page' do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User tries to go to the index page
  #   She is not allowed
  scenario 'user gets booted out and redirected to show page' do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)
    visit notes_path(user)
    expect(page).to have_text("Access denied.")
  end

  # scenario 'admin is allowed access to index page' do
  #   user = FactoryGirl.create(:user)
  #   login_as(user, :scope => :admin)
  #   visit notes_path(user)
  #   expect(page).to have_text(user.email)
  # end

end
