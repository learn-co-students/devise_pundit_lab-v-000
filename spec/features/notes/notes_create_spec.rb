include Warden::Test::Helpers
Warden.test_mode!
# Feature: Note create
#   As a user
#   I want to create a new note
feature 'Create Note' do

  # Scenario: User can create a note content
  #   When I fill out and "save" new note form
  #   Then I see new note on note show page
  scenario 'User can create a note with content' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit new_note_path
    fill_in 'Content', :with => 'Note content'
    click_button 'save'
    expect(page).to have_content('Note content')
  end

  # Scenario: User cannot create a note without content
  #   When I dont fill out then "save" new note form
  #   Then I see an error that it didn't work
  scenario 'User cannot create a note without content' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit new_note_path
    fill_in 'Content', :with => ''
    click_button 'save'
    expect(page).to have_content 'Error.'
  end


end
