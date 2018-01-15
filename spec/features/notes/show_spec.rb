include Warden::Test::Helpers
Warden.test_mode!

feature 'Show Note', :devise do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user can list his or her readable notes' do
    user = FactoryGirl.create(:user, name: 'Me')
    another = FactoryGirl.create(:user, email: 'another@home.com', name: 'Test')
    signin(user.email, user.password)
    note = FactoryGirl.create(:note, user: user, content: 'Note 1')
    another_note = FactoryGirl.create(:note, user: another, visible_to: 'Me, Test', content: 'Note 2')

    visit notes_path(user)

    expect(page).to have_content 'Note 1'
    expect(page).to have_content 'Note 2'
  end

  scenario "user cannot cannot see a note that is not readable", :me do
    me = FactoryGirl.create(:user)
    other = FactoryGirl.create(:user, email: 'other@example.com')
    FactoryGirl.create(:note, user: other, content: "Other note")

    login_as(me, :scope => :user)

    visit notes_path(me)

    expect(page).to_not have_content 'Other note'

  end

  scenario "admin can view any notes", :me do
    me = FactoryGirl.create(:user, :admin)
    other = FactoryGirl.create(:user, email: 'other@example.com')
    FactoryGirl.create(:note, user: other, content: "Other note")

    login_as(me, :scope => :user)

    visit notes_path(me)

    expect(page).to have_content 'Other note'

  end

  scenario "moderator can view any notes", :me do
    me = FactoryGirl.create(:user, :moderator)
    other = FactoryGirl.create(:user, email: 'other@example.com')
    FactoryGirl.create(:note, user: other, content: "Other note")

    login_as(me, :scope => :user)

    visit notes_path(me)

    expect(page).to have_content 'Other note'

  end


end
