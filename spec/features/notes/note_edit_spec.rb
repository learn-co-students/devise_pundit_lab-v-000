include Warden::Test::Helpers
Warden.test_mode!

# Feature: Note edit
#   As a user
#   I want to edit my notes
feature 'Note edit', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User changes note content
  #   Given I am signed in
  #   When I change my note content
  #   Then I see an updated message
  scenario 'user changes content' do
    note = FactoryGirl.create(:note)
    user = FactoryGirl.create(:user)
    user.notes << note
    login_as(user, :scope => :user)
    visit edit_note_path(note)
    fill_in 'Content', :with => 'Hello! test note here'
    click_button 'save'
    expect(page).to have_content('Hello! test note here')
  end

  # Scenario: User changes visible to
  #   Given I am signed in
  #   When I try to edit the visibility
  #   Then my note's readers change
  scenario "user can change the note's visibility", :me do
    me = FactoryGirl.create(:user)
    login_as(me, :scope => :user)
    other = FactoryGirl.create(:user, email: 'other@example.com', name: 'Tom')
    note = FactoryGirl.create(:note, content: 'Hello', visible_to: 'me')
    me.notes << note
    visit edit_note_path(note)
    fill_in 'Visible to', :with => "Tom"
    click_button 'save'
    expect(Note.last.readers.last.name).to eq('Tom')
  end

end