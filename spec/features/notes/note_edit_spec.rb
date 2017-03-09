include Warden::Test::Helpers
Warden.test_mode!

feature 'Note edit', :devise do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user can change the content of her note' do
    user = FactoryGirl.create(:user)
    note = FactoryGirl.create(:note, user: user)
    login_as(user, :scope => :user)
    visit edit_note_path(note)
    expect(page).to have_content("Edit note:")
    fill_in 'note[content]', :with => '...but Mary unfortunately got quite hungry and low on iron'
    click_button 'save'
    expect(page).to have_content("Your note was updated.")
  end

  scenario "user cannot change another user's note", :me do
    me = FactoryGirl.create(:user)
    other = FactoryGirl.create(:user, email: 'other@example.com')
    note = FactoryGirl.create(:note, user: other)
    login_as(me, :scope => :user)
    visit edit_note_path(note)
    expect(page).not_to have_content "Edit note:"
  end

end
