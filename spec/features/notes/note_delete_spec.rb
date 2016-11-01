include Warden::Test::Helpers
Warden.test_mode!

feature 'Note delete', :js do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user can delete own note' do
    user = FactoryGirl.create(:user)
    note = FactoryGirl.create(:note)
    note.user = user
    note.save
    login_as(user, :scope => :user)
    visit note_path(note)
    click_button 'Delete note'
    expect(page).to have_content 'Note deleted.'
  end

  scenario "user cannot delete another user's note" do
    user = FactoryGirl.create(:user)
    note = FactoryGirl.create(:note)
    note.readers << user
    note.save
    login_as(user, :scope => :user)
    visit note_path(note)
    click_button 'Delete note'
    expect(page).to have_content 'Access denied.'
  end

  scenario "moderator cannot delete another user's note" do
    user = FactoryGirl.create(:user, :moderator)
    note = FactoryGirl.create(:note)
    login_as(user, :scope => :user)
    visit note_path(note)
    click_button 'Delete note'
    expect(page).to have_content 'Access denied.'
  end

  scenario "admin can delete another user's note" do
    user = FactoryGirl.create(:user, :admin)
    note = FactoryGirl.create(:note)
    login_as(user, :scope => :user)
    visit note_path(note)
    click_button 'Delete note'
    expect(page).to have_content 'Note deleted.'
  end

end