include Warden::Test::Helpers
Warden.test_mode!

# Feature: Note index page
#   As a user
#   I want to see a list of all of my notes
#   So I can see who has registered
feature 'Notes index page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User notes listed on index page
  #   Given I am signed in
  #   When I visit the note index page
  #   Then I see my own notes
  scenario 'user sees own note content' do
    user = FactoryGirl.create(:user)
    note_1 = FactoryGirl.create(:note)
    note_2 = FactoryGirl.create(:note)
    note_1.user = user
    note_2.user = user
    login_as(user, scope: :user)
    visit notes_path
    expect(page).to have_content note_1.content
    expect(page).to have_content note_2.content
  end

end
