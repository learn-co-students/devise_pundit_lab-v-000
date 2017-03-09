include Warden::Test::Helpers
Warden.test_mode!

feature 'Note read', :devise do

  after(:each) do
    Warden.test_reset!
  end

  scenario 'user can read her own note' do
    user = FactoryGirl.create(:user)
    note = FactoryGirl.create(:note, user: user, content: "Hello world")
    login_as(user, :scope => :user)
    visit note_path(note)
    expect(page).to have_content("Hello world")
  end

  scenario 'moderator can read any note' do
    user = FactoryGirl.create(:user)
    moderator = FactoryGirl.create(:user, :moderator, email: "moderator_dude@gmail.com")
    note = FactoryGirl.create(:note, user: user, content: "Hello moderator, you spy!")
    login_as(moderator, :scope => :user)
    visit note_path(note)
    expect(page).to have_content("Hello moderator, you spy!")
  end

  scenario 'admin can read any note' do
    user = FactoryGirl.create(:user)
    admin = FactoryGirl.create(:user, :admin, email: "admin_lady@gmail.com")
    note = FactoryGirl.create(:note, user: user, content: "Hello admin, you creep!")
    login_as(admin, :scope => :user)
    visit note_path(note)
    expect(page).to have_content("Hello admin, you creep!")
  end
  
  scenario 'a rando cannot read your note' do
    user = FactoryGirl.create(:user)
    rando = FactoryGirl.create(:user, email: "rando@gmail.com")
    note = FactoryGirl.create(:note, user: user, content: "I'm a secret, hidden from random strangers.")
    login_as(rando, :scope => :user)
    visit note_path(note)
    expect(page).not_to have_content("I'm a secret, hidden from random strangers.")
  end

  scenario 'a person to whom the author has granted permission can read the note' do 
    user = FactoryGirl.create(:user)
    friend = FactoryGirl.create(:user, email: "friend@gmail.com")
    note = FactoryGirl.create(:note, user: user, content: "Hi friend. Thanks for viewing my note.")
    viewer = FactoryGirl.create :viewer, user: friend, note: note
    note.viewers << viewer
    login_as(friend, :scope => :user)
    visit note_path(note)
    expect(page).to have_content("Hi friend. Thanks for viewing my note.")
  end

end
