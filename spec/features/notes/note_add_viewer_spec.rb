include Warden::Test::Helpers
Warden.test_mode!

feature 'Users can add viewers to their notes', :devise do

  after(:each) do
    Warden.test_reset!
  end
    
  scenario 'user can add viewers to notes they created' do
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user, email: "otheremail@me.com", name: "otheruser")
    login_as(user, :scope => :user)
    new_note = user.notes.create(content: 'my new note')
    visit edit_note_path(new_note)
    fill_in "note_content", with: "my new note - edited"
    fill_in "note_visible_to", with: "otheruser"
    click_button "save"
    click_link "Sign out"
    login_as(other_user, :scope => :user)
    visit notes_path
    expect(page).to have_content('my new note - edited')
  end

end
