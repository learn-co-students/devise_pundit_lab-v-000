include Warden::Test::Helpers
Warden.test_mode!

feature 'Users can remove viewers from their notes', :devise do

  after(:each) do
    Warden.test_reset!
  end
    
  scenario 'user can remove viewers from notes they created' do
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user, email: "otheremail@me.com", name: "otheruser")
    login_as(user, :scope => :user)
    new_note = user.notes.create(content: 'my new note')
    visit edit_note_path(new_note)
    fill_in "note_content", with: "my new note - edited"
    fill_in "note_visible_to", with: "otheruser"
    click_button "save"
    visit edit_note_path(new_note)
    fill_in "note_content", with: "otheruser can't see it anymore"
    fill_in "note_visible_to", with: ""
    click_button "save"
    click_link "Sign out"
    login_as(other_user, :scope => :user)
    visit notes_path
    expect(page).not_to have_content("otheruser can't see it anymore")
  end

end
