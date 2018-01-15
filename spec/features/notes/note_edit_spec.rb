include Warden::Test::Helpers
Warden.test_mode!

feature 'Note create' do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'User can edit a note' do
    user = FactoryGirl.create(:user, :admin)
    user2 = User.create!(name: "Second_User", email: "sdfvghksfrvgnhj@f.a", password: "sfghswrdgrkjhswgjk")
    user3 = User.create!(name: "Third_User", email: "sdfvghksfrvgnj@f.a", password: "sfghswrdgrkjhswgjk")
    login_as(user, scope: :user)
    note = Note.create!(content: "Original Contents", visible_to: user2.name, user: user)

    visit edit_note_path(note)
    fill_in :note_content, with: "Note Contents"
    fill_in :note_visible_to, with: user3.name
    click_on "save"

    note.reload
    expect(note.content).to eq("Note Contents")
    expect(note.readers.include?(user2)).to be(false)
    expect(note.readers.include?(user3)).to be(true)
  end

end
