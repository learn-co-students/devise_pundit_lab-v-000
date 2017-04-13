include Warden::Test::Helpers
Warden.test_mode!

# Feature: CRUD notes
#   As a user
#   I want to create, read, and update notes

feature 'Notes CRUD', :devise do

    after(:each) do
        Warden.test_reset!
    end

    # Scenario: user creates a new note
    scenario 'user can create a new note' do
        user = FactoryGirl.create(:user)
        login_as(user, :scope => :user)
        visit new_note_path
        fill_in 'Content', :with => 'My first note'
        click_button 'Create'
        expect(page).to have_content('My first note')
    end

    scenario 'user can edit their own note' do
        user = FactoryGirl.create(:user)
        login_as(user, :scope => :user)
        visit new_note_path
        fill_in 'Content', :with => 'My first note'
        click_button 'Create Note'
        click_link('edit') 
        fill_in 'Content', :with => "My first edited note"
        click_button 'Update Note'
        expect(page).to have_content('My first edited note')
    end

    scenario 'user can delete their own note' do
        user = FactoryGirl.create(:user)
        login_as(user, :scope => :user)
        visit new_note_path
        fill_in 'Content', :with => 'My first note'
        click_button 'Create'
        click_link('edit')
        click_button 'Delete Note'
        expect(page).to_not have_content('My first note')
    end

    scenario "user cannot edit someone else's note" do
        suzie = User.create(name:"Suzie",email:"suzie@apple.com",password:"password")
        suzie.notes.create(content:"Other user's note")
        sam = User.create(name:"Sam",email:"sam@microsoft.com",password:"password")
        suzie.notes.first.visible_to="Sam"
        signin(sam.email,sam.password)
        visit notes_path
        expect(page).to have_content("Other user's note")
        expect(page).to_not have_content('edit')
    end
end
