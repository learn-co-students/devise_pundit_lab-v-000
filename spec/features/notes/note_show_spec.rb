include Warden::Test::Helpers
Warden.test_mode!

feature 'Note show page', :devise do

  build_notes

  after(:each) do
    Warden.test_reset!
  end

  scenario 'Shows author and readers' do
    test_user=one_user
    test_note=one_note
    another_note.readers << test_user
    another_note.save
    login_as(test_user)
    visit note_path(another_note)
    expect(page).to have_content(test_user.name)
    expect(page).to have_content(another_user.name)
  end


  scenario 'Shows notes written by or to user' do
    test_user=one_user
    test_note=one_note
    another_note.readers << test_user
    another_note.save
    login_as(test_user)
    visit note_path(another_note)
    expect(page).to have_content("other user's note")
  end

  scenario 'users can see links to edit their posts' do
    test_user=User.create(email: "test@email.com", password: "testtest", name: "test")
    test_note=test_user.notes.build(content: "test note")
    test_note.save
    login_as(test_user)
    visit note_path(test_note)
    expect(page).to have_link('Edit note')

  end

  scenario 'vip can see any note' do
    login_as(vip)
    visit note_path(one_note)
    expect(page).to have_content("current user's note")
  end

  scenario 'vip cannot edit other user notes' do
    login_as(vip)
    visit note_path(one_note)
    expect(page).not_to have_link("Edit note")
  end 

  scenario 'admins can see and edit any post' do
    login_as(admin)
    visit note_path(one_note)
    expect(page).to have_content(one_note.content)
    expect(page).to have_link("Edit note")
  end

  scenario 'only admins can delete a post' do
    login_as(admin)
    visit note_path(one_note)
    expect(page).to have_button("Delete")

    login_as(vip)
    visit note_path(one_note)
    expect(page).not_to have_button("Delete")    
  end
  




  # # Scenario: User sees own profile
  # #   Given I am signed in
  # #   When I visit the user profile page
  # #   Then I see my own email address
  # scenario 'user sees own profile' do
  #   user = FactoryGirl.create(:user)
  #   login_as(user, :scope => :user)
  #   visit user_path(user)
  #   expect(page).to have_content 'User'
  #   expect(page).to have_content user.email
  # end

  # # Scenario: User cannot see another user's profile
  # #   Given I am signed in
  # #   When I visit another user's profile
  # #   Then I see an 'access denied' message
  # scenario "user cannot see another user's profile" do
  #   me = FactoryGirl.create(:user)
  #   other = FactoryGirl.create(:user, email: 'other@example.com')
  #   login_as(me, :scope => :user)
  #   Capybara.current_session.driver.header 'Referer', root_path
  #   visit user_path(other)
  #   expect(page).to have_content 'Access denied.'
  # end

end
