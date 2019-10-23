feature 'Add note', :devise do

  scenario 'user cannot add a new note if not logged in' do
    visit new_note_path
    expect(page).to have_content "You need to sign in or sign up before continuing"
  end

  scenario 'user can add a new note if logged in' do
    user = FactoryGirl.create(:user)
    #other_user = FactoryGirl.create(:other_user)
    signin(user.email, user.password)
    visit new_note_path
    fill_in :note_content, with: "content!"
    fill_in :note_visible_to, with: "Another"
    click_button "save"
    expect(page).to have_content "content!"
  end

end
