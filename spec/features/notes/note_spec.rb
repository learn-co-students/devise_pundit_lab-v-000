feature 'Note' do
  scenario 'users can create their own notes' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit user_path(user)
    click_link("New Note")
    fill_in 'Content', with: 'I am a new note!'
    click_on "save"
    expect(page).to have_content 'I am a new note!'
  end

  scenario 'users can update their own notes' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit user_path(user)
    click_link("New Note")
    fill_in 'Content', with: 'I am a different note!'
    click_on "save"
    expect(page).to have_content 'I am a different note!'
    click_link "Edit Note"
    fill_in 'Content', with: 'I am an edited note!'
    click_on 'save'
    expect(page).to have_content 'I am an edited note!'
  end

  scenario 'users can delete their own notes' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit user_path(user)
    click_link("New Note")
    fill_in 'Content', with: 'I am a new note.'
    click_on 'save'
    expect(page).to have_content 'I am a new note.'
    click_link("Delete Note")
    expect(page).to_not have_content 'I am a new note.'
  end

end
