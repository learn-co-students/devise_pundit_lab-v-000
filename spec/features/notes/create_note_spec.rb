feature 'Create Note' do

  scenario 'logged in user can create a note' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    visit new_note_path
    fill_in 'Content', with: "This is a new note"
    click_button 'save'
    expect(page).to have_content 'This is a new note'
  end

  scenario 'admin user can create a note' do
    user = FactoryGirl.create(:user, :admin)
    signin(user.email, user.password)
    visit new_note_path
    fill_in 'Content', with: "This is a new note"
    click_button 'save'
    expect(page).to have_content 'This is a new note'
  end
end
