include Warden::Test::Helpers
Warden.test_mode!

# Feature: User edit
#   As a user
#   I want to create a new note
#   So I can change my email address
feature 'Note create', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Create a new note
  #   Given I am signed in
  #   When I create a new note
  #   It appears in my notes index
  scenario 'user creates a new note' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit new_note_path
    fill_in 'Content', :with => 'this is content!!! test'
    click_button 'save'
    expect(page).to have_content('this is content!!! test')
  end

end
