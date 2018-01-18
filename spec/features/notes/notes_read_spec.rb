include Warden::Test::Helpers
Warden.test_mode!

RSpec.feature NotesController, type: :feature do

	after(:each) do
    Warden.test_reset!
  end

	let (:current_user) { 
		User.create(confirmed_at: Time.now, name: "Test User", 
		email: "test1@example.com", password: "please123")
		}
  
  let (:other_user) { 
  	User.create(confirmed_at: Time.now, name: "Other User", 
		email: "test2@example.com", password: "please123")
		}
  
  let (:vip) { 
  	User.create(confirmed_at: Time.now, name: "Vip User", 
		email: "test3@example.com", password: "please123", role: "vip")
		}
  
  let (:admin) { 
  	User.create(confirmed_at: Time.now, name: "Admin User", 
		email: "test4@example.com", password: "please123", role: "admin") 
  }
  
  let (:note_1) { Note.create( content: "Note 1", user: current_user) }
  let (:note_2) { Note.create( content: "Note 2", user: other_user) }
  let (:note_3) { Note.create( content: "Note 3") }


	scenario "can't see notes unless signed in" do

		visit notes_path
		expect(page).to_not have_content(note_1.content)
	end

	scenario 'user can only see notes they created' do
		note_1.save
		note_2.save
		signin(current_user.email, current_user.password)
		visit notes_path

		expect(page).to_not have_content(note_2.content)
		expect(page).to have_content(note_1.content)

	end

	
end
