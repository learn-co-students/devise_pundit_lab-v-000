include Warden::Test::Helpers
Warden.test_mode!

feature 'Note show', :devise do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user can see notes they created' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    new_note = user.notes.create(content: 'my new note')
    visit note_path(new_note)
    expect(page).to have_content('my new note')
  end

  scenario "user cannot cannot see other user's private notes" do
    me = FactoryGirl.create(:user)
    other = FactoryGirl.create(:user, email: 'other@example.com')
    private_note = other.notes.create(content: 'my private note')
    login_as(me, scope: :user)
    visit note_path(private_note)
    expect(page).not_to have_content('my private note')
    expect(page.current_path).to eq(notes_path)
  end

end
