include Warden::Test::Helpers
Warden.test_mode!

feature 'Note show', :js do

  after(:each) do
    Warden.test_reset!
  end

  let!(:user) { FactoryGirl.create(:user) }
  let!(:other_user) { FactoryGirl.create(:user, :email => 'other@gmail.com', :name => 'Other User')}
  let!(:moderator) { FactoryGirl.create(:user, :moderator, :email => 'moderator@gmail.com', :name => 'Moderator') }
  let!(:admin) { FactoryGirl.create(:user, :admin, :email => 'admin@gmail.com', :name => 'Admin') }
  let!(:user_note) { FactoryGirl.create(:note, :user_id => user.id) }
  let!(:other_user_note) { FactoryGirl.create(:note, :content => 'Other Note', :user_id => other_user.id, visible_to: 'Test User' )}

  scenario 'user can see a note that belongs to them' do
    login_as(user, :scope => :user)
    visit note_path(user_note)
    expect(page).to have_content 'Test Note'
  end

  scenario "user can see a note that is visible to them" do
    login_as(user, :scope => :user)
    visit note_path(other_user_note)
    expect(page).to have_content 'Other Note'
  end

  scenario "user cannot see a note that is not visible to them" do
    login_as(other_user, :scope => :user)
    visit note_path(user_note)
    expect(page).to have_content 'Access denied.'
  end

  scenario "moderator can see any note" do
    login_as(moderator, :scope => :user)
    visit note_path(user_note)
    expect(page).to have_content 'Test Note'
  end

  scenario "admin can see any note" do
    login_as(admin, :scope => :user)
    visit note_path(user_note)
    expect(page).to have_content 'Test Note'
  end

end