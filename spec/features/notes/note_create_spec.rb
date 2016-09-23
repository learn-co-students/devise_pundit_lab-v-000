include Warden::Test::Helpers
Warden.test_mode!

# Feature: User edit
#   As a user
#   I want to edit my user profile
#   So I can change my email address
feature 'Note create', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User changes email address
  #   Given I am signed in
  #   When I change my email address
  #   Then I see an account updated message
  scenario 'user create notes' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit new_note_path
    fill_in 'Content', :with => 'new note'

    click_button 'save'
    txts = [I18n.t( 'devise.registrations.updated'), I18n.t( 'devise.registrations.update_needs_confirmation')]
    expect(page).to have_content('new note')
  end

  # Scenario: User cannot edit another user's profile
  #   Given I am signed in
  #   When I try to edit another user's profile
  #   Then I see my own 'edit profile' page
  # scenario "user cannot cannot edit another user's profile", :me do
  #   me = FactoryGirl.create(:user)
  #   other = FactoryGirl.create(:user, email: 'other@example.com')
  #   login_as(me, :scope => :user)
  #   visit edit_user_registration_path(other)
  #   expect(page).to have_content 'Edit User'
  #   expect(page).to have_field('Email', with: me.email)
  # end

end
