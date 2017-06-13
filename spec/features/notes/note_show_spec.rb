include Warden::Test::Helpers
Warden.test_mode!

# Feature: Note page
#   As a user
#   I want to view my note
feature 'Note show page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User sees own note
  #   Given I am signed in
  #   When I visit the note show page
  #   Then I see the note content
  scenario 'user sees own note' do
    user = FactoryGirl.create(:user)
    note = user.notes.create(content: "Love Noisli while programming!")
    login_as(user, :scope => :user)
    visit note_path(note)
    expect(page).to have_content user.notes.first.content
  end

  # Scenario: User cannot see another user's notes
  #   Given I am signed in
  #   When I visit another user's note page
  #   Then I see an 'access denied' message
  scenario "user cannot see another user's notes" do
    me = FactoryGirl.create(:user)
    my_note = me.notes.create(content: "My favorite superhero is Superman")
    other = FactoryGirl.create(:user, email: 'other@example.com')
    other_note = other.notes.create(content: "I'm all about Batman")
    login_as(me, :scope => :user)
    Capybara.current_session.driver.header 'Referer', root_path
    visit note_path(other_note)
    expect(page).to have_content 'Access denied.'
  end

end
