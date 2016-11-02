include Warden::Test::Helpers
Warden.test_mode!

feature 'Note create', :js do

  after(:each) do
    Warden.test_reset!
  end

  let!(:user) { FactoryGirl.create(:user) }
  let!(:other_user) { FactoryGirl.create(:user, :email => 'other@gmail.com', :name => 'Other User')}

  scenario 'user can create a note that belongs to them' do
    login_as(user, :scope => :user)
    visit new_note_path
    fill_in 'Content', :with => 'New note content.'
    fill_in 'Visible to', :with => 'Other User'
    click_button 'save'
    expect(page).to have_content 'Created note.'
    note = Note.last
    expect(note.readers).to include(other_user)
    expect(note.content).to eq('New note content.')
  end

end