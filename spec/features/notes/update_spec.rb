include Warden::Test::Helpers
Warden.test_mode!

feature 'Update Note', :devise do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user can edit a note owned by himself' do
    user = FactoryGirl.create(:user)
    signin(user.email, user.password)
    click_link 'New Note'
    fill_in 'Content', :with => 'A secret test note'
    click_button 'save'

    click_link 'A secret test note'
    click_link 'Edit'

    fill_in 'Content', :with => 'An updated note'
    click_button 'save'

    expect(page).to have_content 'An updated note'
  end

  scenario "user cannot cannot edit another user's note", :me do
    me = FactoryGirl.create(:user)
    other = FactoryGirl.create(:user, email: 'other@example.com')
    note = FactoryGirl.create(:note, user: other)

    login_as(me, :scope => :user)

    visit edit_note_path(note)

    expect(page).to have_content 'Access forbidden.'

  end

  scenario "admin can edit another user's note", :me do
    me = FactoryGirl.create(:user, :admin)
    other = FactoryGirl.create(:user, email: 'other@example.com')
    note = FactoryGirl.create(:note, user: other)

    login_as(me, :scope => :user)

    visit edit_note_path(note)

    expect(page).to_not have_content 'Access forbidden.'

  end


end
