include Warden::Test::Helpers
Warden.test_mode!

feature 'Note index', :js do

  after(:each) do
    Warden.test_reset!
  end

  let!(:user) { FactoryGirl.create(:user) }
  let!(:other_user) { FactoryGirl.create(:user, :email => 'other@gmail.com', :name => 'Other User')}
  let!(:moderator) { FactoryGirl.create(:user, :moderator, :email => 'moderator@gmail.com', :name => 'Moderator') }
  let!(:admin) { FactoryGirl.create(:user, :admin, :email => 'admin@gmail.com', :name => 'Admin') }
  let!(:user_note) { FactoryGirl.create(:note, :user_id => user.id) }
  let!(:other_user_note) { FactoryGirl.create(:note, :content => 'Other Note', :user_id => other_user.id, visible_to: 'Test User' )}

  scenario 'user can see list of readable notes' do
    login_as(user, :scope => :user)
    visit notes_path
    expect(page).to have_content 'Test Note'
    expect(page).to have_content 'Other Note'
  end

  scenario "user's list of readable note contains only notes readable to them" do
    login_as(other_user, :scope => :user)
    visit notes_path
    expect(page).to have_content 'Other Note'
    expect(page).not_to have_content 'Test Note'
  end

  scenario "moderator can see a list of all notes" do
    login_as(moderator, :scope => :user)
    visit notes_path
    expect(page).to have_content 'Test Note'
    expect(page).to have_content 'Other Note'
  end

  scenario "admin can see a list of all notes" do
    login_as(admin, :scope => :user)
    visit notes_path
    expect(page).to have_content 'Test Note'
    expect(page).to have_content 'Other Note'
  end

end