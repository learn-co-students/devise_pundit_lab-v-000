RSpec.describe NotePolicy do
	subject { NotePolicy }

	let (:current_user) { User.create(confirmed_at: Time.now, name: "Test User", 
												email: "test@example.com", password: "please123") }
  let (:other_user) { User.create(confirmed_at: Time.now, name: "Other User", 
												email: "test@example.com", password: "please123") }
  let (:vip) { User.create(confirmed_at: Time.now, name: "Vip User", 
												email: "test@example.com", password: "please123", role: "vip") }
  let (:admin) { User.create(confirmed_at: Time.now, name: "Admin User", 
												email: "test@example.com", password: "please123", role: "admin") }
  let (:note_1) { Note.create( content: "Note 1", user: current_user) }
  let (:note_2) { Note.create( content: "Note 1", user: other_user) }
  let (:note_3) { Note.create( content: "Note 1") }

  permissions :create? do
  	it "allows a user to create a new note" do
  		expect(NotePolicy).to permit(current_user, note_1)
  	end

  	it "doesn't allow a user to create a note they don't own" do
  		expect(NotePolicy).to_not permit(current_user, note_2)
  	end

  	it "allows a user with admin access to create a note" do
  		expect(subject).to permit(admin, note_1)
  	end
  end
end