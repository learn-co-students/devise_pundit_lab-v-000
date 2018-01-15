include Warden::Test::Helpers
Warden.test_mode!

# Feature: Note edit
#   As a user or admin
#   I want to edit my notes or another user's notes
#   So I can change the content
feature 'Note edit', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User/admin changes note content
  #   Given I am signed in
  #   When I change my note content
  #   Then I see an account updated message
  scenario 'user changes email address' do
    user = FactoryGirl.create(:user)
    note = user.notes.create(content: "pistachio ice cream is the best")
    login_as(user, :scope => :user)
    visit edit_note_path(note)
    fill_in 'Content', :with => 'hazelnut ice cream is the best'
    click_button 'Update'
    expect(page).to have_content('hazelnut')
  end

  # Scenario: User cannot edit another user's note
  #   Given I am signed in
  #   When I try to edit another user's note
  #   Then I see my own notes index page
  scenario "user cannot cannot edit another user's notes", :me do
    me = FactoryGirl.create(:user)
    my_note = me.notes.create(content: "my cool note")
    other = FactoryGirl.create(:user, email: 'other@example.com')
    other_note = other.notes.create(content: "someone's else note")
    login_as(me, :scope => :user)
    visit edit_note_path(other_note)
    expect(page).to have_content 'Welcome'
  end

end
