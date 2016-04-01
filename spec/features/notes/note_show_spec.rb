include Warden::Test::Helpers
Warden.test_mode!

# Feature: User profile page
#   As a user
#   I want to visit my user profile page
#   So I can see my personal account data
feature 'Note show page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User sees own note
  #   Given I am signed in
  #   When I visit the note show page
  #   Then I see my own note
  scenario 'user sees own note' do
    user = FactoryGirl.create(:user)
    user.notes << FactoryGirl.create(:note, content: 'Whassup??')
    login_as(user, :scope => :user)
    visit note_path(user.notes.last)
    expect(page).to have_content 'Whassup??'
  end

  # Scenario: User cannot see another user's note
  #   Given I am signed in
  #   When I visit another user's viewers note
  #   Then I see an authorization error
  scenario "user cannot see another user's note" do
    me = FactoryGirl.create(:user)
    other = FactoryGirl.create(:user, email: 'other@example.com')
    other.notes << FactoryGirl.create(:note, content: "Hola")
    login_as(me, :scope => :user)
    visit note_path(other.notes.last)
    expect(page).to have_content 'BE GONE'
  end

end
