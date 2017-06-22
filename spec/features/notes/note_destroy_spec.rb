include Warden::Test::Helpers
Warden.test_mode!

feature 'Note create' do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'User can destory a note' do
    user = FactoryGirl.create(:user, :admin)
    user2 = User.create!(name: "Second_User", email: "sdfvghksfrvgnhj@f.a", password: "sfghswrdgrkjhswgjk")
    login_as(user, scope: :user)
    visit new_note_path
    fill_in :note_content, with: "Note Contents"
    fill_in :note_visible_to, with: user2.name
    click_on "save"

    note = Note.last
    expect(note.content).to eq("Note Contents")
    expect(note.readers.include?(user2)).to be(true)
  end

end
