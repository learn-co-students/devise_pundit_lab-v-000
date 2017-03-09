include Warden::Test::Helpers
Warden.test_mode!

feature 'Note create', :devise do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user can create a note' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit new_note_path
    expect(page).to have_content("New note:")
    fill_in 'note[content]', :with => 'The content of a note created by a test as if in the browser'
    click_button 'save'
    expect(page).to have_content("Your note was created.")
    expect(page).to have_content("The content of a note created by a test as if in the browser")
  end

end
