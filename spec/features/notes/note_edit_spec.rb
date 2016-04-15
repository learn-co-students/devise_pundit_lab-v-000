include Warden::Test::Helpers
Warden.test_mode!

feature 'Note edit', :devise do

  build_notes

  after(:each) do
    Warden.test_reset!
  end

  scenario 'users can edit their posts' do
    login_as(one_user)
    visit edit_note_path(one_note)
    fill_in 'Content', :with => 'edited content'
    click_button 'save'
    expect(page).to have_content('edited content')
  end

end
