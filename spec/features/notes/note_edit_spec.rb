include Warden::Test::Helpers
Warden.test_mode!

feature 'Note edit', :devise do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user can edit notes they created' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    new_note = user.notes.create(content: 'my new note')
    visit edit_note_path(new_note)
    fill_in "note_content", with: "my new note - edited"
    click_button "save"
    expect(page).to have_content('my new note - edited')
  end

  scenario "user cannot cannot edit other user's notes" do
    me = FactoryGirl.create(:user)
    other = FactoryGirl.create(:user, email: 'other@example.com')
    private_note = other.notes.create(content: 'my note', visible_to: me.name)
    login_as(me, scope: :user)
    visit edit_note_path(private_note)
    expect(page).to have_content("You don't have permission to do that")
    expect(page.current_path).to eq(notes_path)
  end

end
