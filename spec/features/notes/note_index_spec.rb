include Warden::Test::Helpers
Warden.test_mode!

feature 'Note index', :devise do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user can see notes they created' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit new_note_path
    fill_in 'note_content', :with => 'my new note'
    click_button 'save'
    visit new_note_path 
    fill_in 'note_content', :with => 'note number 2!'
    click_button 'save'
    visit notes_path 
    expect(page).to have_content('my new note')
    expect(page).to have_content('note number 2!')
  end

  scenario "user cannot cannot see other user's private notes" do
    me = FactoryGirl.create(:user)
    other = FactoryGirl.create(:user, email: 'other@example.com')
    login_as(other, :scope => :user)
    visit new_note_path
    fill_in 'note_content', with: 'my private note'
    click_button 'save'
    click_link "Sign out"
    login_as(me, scope: :user)
    visit notes_path
    expect(page).not_to have_content('my private note')
  end

end
