include Warden::Test::Helpers
Warden.test_mode!

# Feature: Note edit
#   As a user
#   I want to edit my user profile
#   So I can change my email address
feature 'Note edit', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User changes note
  #   Given I am signed in
  #   When I change my note
  #   Then I see an updated note
  scenario 'user changes note' do
    user = FactoryGirl.create(:user)
    note = FactoryGirl.create(:note)
    login_as(user, :scope => :user)
    visit edit_note_path(user)
    fill_in 'Content', :with => 'my new note'

    # txts = [I18n.t( 'devise.registrations.updated'), I18n.t( 'devise.registrations.update_needs_confirmation')]
    expect(page).to have_content('Content')
  end

  # Scenario: Note cannot edit another user's profile
  #   Given I am signed in
  #   When I try to edit another user's profile
  #   Then I see my own 'edit profile' page
  # scenario "user cannot cannot edit another user's profile", :me do
  #   me = FactoryGirl.create(:user)
  #   other = FactoryGirl.create(:user, email: 'other@example.com')
  #   login_as(me, :scope => :user)
  #   visit edit_user_registration_path(other)
  #   expect(page).to have_content 'Edit Note'
  #   expect(page).to have_field('Email', with: me.email)
  # end

end
