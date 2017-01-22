include Warden::Test::Helpers
Warden.test_mode!

# Feature: User edit
#   As a user
#   I want to edit my user profile
#   So I can change my email address
feature 'Note edit', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User changes note contents
  #   Given I am signed in
  #   When I edit my note
  #   Then I see a note updated message
  scenario 'user edits their note' do
    user = FactoryGirl.create(:user)
    note = FactoryGirl.create(:note, content: 'you can see me', user_id: user.id)
    login_as(user, :scope => :user)
    visit edit_note_path(note)
    fill_in 'Content', :with => 'can you still see me?'
    click_button 'save'
  end

  # Scenario: User cannot edit another user's note
  #   Given I am signed in
  #   When I try to edit another user's note
  #   Then I see my own 'edit note' page
  scenario "user cannot edit another user's note" do
    me = FactoryGirl.create(:user, email: 'me@example.com')
    other = FactoryGirl.create(:user, email: 'other@example.com')
    note = FactoryGirl.create(:note, content: 'not for you', user_id: me.id)
    login_as(other, :scope => :user)
    visit edit_note_path(note)
    expect(page).to have_content 'Access denied.'
  end

end
