include Warden::Test::Helpers
Warden.test_mode!

# Feature: User edit
#   As a user
#   I want to edit my user profile
#   So I can change my email address
feature 'Note new', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User fills out note contents
  #   Given I am signed in
  #   When I submit a new note
  #   Then I see a note created message
  scenario 'user creates a new note' do
    user = FactoryGirl.create(:user)
    #note = FactoryGirl.create(:note, content: 'you can see me', user_id: user.id)
    login_as(user, :scope => :user)
    visit new_note_path
    fill_in 'Content', :with => 'now you see me'
    fill_in 'Visible to', with: 'The Great One'
    click_button 'save'
  end

end
