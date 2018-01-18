include Warden::Test::Helpers
Warden.test_mode!

feature 'create note' do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user can create note' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit new_note_path
    fill_in 'Content', with: 'new note'
    fill_in 'Visible to', with: 'dan, gary'
    click_button 'save'
    expect(page).to have_content('new note')
  end

  scenario 'cant create note if not logged in' do
  	visit new_note_path
  	expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

end

