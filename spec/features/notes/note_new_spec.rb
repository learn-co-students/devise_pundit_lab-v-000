include Warden::Test::Helpers
Warden.test_mode!


feature "Note new", :devise do

  build_notes


  after(:each) do
    Warden.test_reset!
  end

  scenario 'Users must be logged in to create notes' do
    visit new_note_path
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end

  scenario 'Users can create notes' do
    login_as(one_user)
    visit new_note_path
    fill_in "note_content", with: "spec content"
    click_button "save"
    expect(page).to have_content("spec content")
  end

  scenario 'Notes are visible to owner-specified readers' do
    test_user=User.create(email: "test@email.com", password: "testtest", name: "test")
  # byebug 
    login_as(another_user)
    visit new_note_path
    fill_in "note_content", with: "other spec content"
    fill_in "note_visible_to", with: "test"
    click_button "save"
    click_link "Sign out"
    login_as(test_user)
    visit user_path(test_user)
    expect(page).to have_content("other spec content")
  end



end
