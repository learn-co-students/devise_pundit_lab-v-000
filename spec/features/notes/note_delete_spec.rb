include Warden::Test::Helpers
Warden.test_mode!

feature 'Note delete', :devise do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user can delete notes they created', js: true do
    skip 'skip a slow test'
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    new_note = user.notes.create(content: 'my new note')
    visit edit_note_path(new_note)
    click_link 'Delete'
    sleep 10.seconds
    a = page.driver.browser.switch_to.alert
    expect(a.text).to eq("Are you sure you want to delete this note?")
    a.accept
    expect(page).not_to have_content('my new note')
  end

  

end
