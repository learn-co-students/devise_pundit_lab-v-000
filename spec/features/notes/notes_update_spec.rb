include Warden::Test::Helpers
Warden.test_mode!

RSpec.feature NotesController, type: :feature do

	before(:each) {
		@user = FactoryGirl.create(:user)
		@note = Note.new(content: "new note", user: @user)
		@note.save
	}

	after(:each) do
    Warden.test_reset!
  end

	scenario 'user can update note they created' do
		login_as(@user, scope: :user)
		visit edit_note_path(@note)
		fill_in 'Content', with: "new content"
		click_on "save"
		visit note_path(@note)
		expect(page).to have_content('new content')

	end

	scenario "user can't update note they didn't create" do
		other_user = User.create(confirmed_at: Time.now, name: "Test User", 
			email: "test1@example.com", password: "please123")
		login_as(@user, scope: :user)
		@note.update(user: other_user)
		visit edit_note_path(@note)
		expect(page).to have_content("Access denied.")

	end

	scenario "admin can update note they didn't create" do
		admin_user = User.create(confirmed_at: Time.now, name: "Test User", 
			email: "test1@example.com", password: "please123", role: :admin)
		login_as(admin_user, scope: :user)
		visit edit_note_path(@note)
		fill_in 'Content', with: "new content"
		click_on "save"
		visit note_path(@note)
		expect(page).to have_content('new content')
	end

end

		
