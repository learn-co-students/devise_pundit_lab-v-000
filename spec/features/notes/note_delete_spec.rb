include Warden::Test::Helpers
Warden.test_mode!

feature 'Note delete', :js do

  after(:each) do
    Warden.test_reset!
  end

  let!(:user) { FactoryGirl.create(:user) }
  let!(:other_user) { FactoryGirl.create(:user, :email => 'other@gmail.com', :name => 'Other User')}
  let!(:moderator) { FactoryGirl.create(:user, :moderator, :email => 'moderator@gmail.com', :name => 'Moderator') }
  let!(:admin) { FactoryGirl.create(:user, :admin, :email => 'admin@gmail.com', :name => 'Admin') }
  let!(:note) { FactoryGirl.create(:note, :user_id => user.id, visible_to: 'Other User') }

  scenario 'user can delete own note' do
    login_as(user, :scope => :user)
    visit note_path(note)
    click_button 'Delete note'
    expect(page).to have_content 'Note deleted.'
  end

  scenario "user cannot delete another user's note" do
    login_as(other_user, :scope => :user)
    visit note_path(note)
    click_button 'Delete note'
    expect(page).to have_content 'Access denied.'
  end

  scenario "moderator cannot delete another user's note" do
    login_as(moderator, :scope => :user)
    visit note_path(note)
    click_button 'Delete note'
    expect(page).to have_content 'Access denied.'
  end

  scenario "admin can delete another user's note" do
    login_as(admin, :scope => :user)
    visit note_path(note)
    click_button 'Delete note'
    expect(page).to have_content 'Note deleted.'
  end

end