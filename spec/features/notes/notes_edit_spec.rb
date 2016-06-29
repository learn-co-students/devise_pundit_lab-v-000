include Warden::Test::Helpers
Warden.test_mode!
# Feature: Note edit
#   As a user
#   I want to edit a note
feature 'Edit Note', :devise do

  # Scenario: User can edit their notes
  #   When I make changes to my notes and "Update" note form
  #   I see new content on note show page
  scenario 'User can edit their own notes' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    note = FactoryGirl.create(:note)
    note.user_id = user.id
    visit edit_note_path(note)
    fill_in 'Content', :with => 'New Note content'
    click_button 'save'
    expect(page).to have_content('New Note content')

    
  end

  # Scenario: User cannot edit other users notes
  #   When I try to edit another user's note
  #   Then I see an access denied error.
  scenario 'User cannot edit other notes', :me do
    me = FactoryGirl.create(:user)
    other = FactoryGirl.create(:user, email: 'other@example.com')
    other_note = FactoryGirl.create(:note, user_id: 2)
    other_note.user = other
    login_as(me, :scope => :user)
    visit edit_note_path(other_note.id)
    fill_in 'Content', :with => 'New Note content'
    click_button 'save'
    expect(page).to have_content 'Access denied.'
  end



end
