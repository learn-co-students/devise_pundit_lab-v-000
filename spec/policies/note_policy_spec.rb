RSpec.describe NotePolicy do
	subject { NotePolicy }

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

  let(:scope) { Note }

  permissions :create? do
  	it "allows a user to create a new note" do
  		expect(subject).to permit(current_user, note_1)
  	end

  	it "doesn't allow a user to create a note they don't own" do
  		expect(subject).to_not permit(current_user, note_2)
  	end

  	it "allows a user with admin access to create a note" do
  		expect(subject).to permit(admin, note_1)
  	end
  end

  permissions :update? do
  	it "allows user to update their own note" do
  		expect(subject).to permit(current_user, note_1)
  	end

  	it "doesn't allow a user to edit someone else's post" do
  		expect(subject).to_not permit(current_user, note_2)
  	end

  	it "allows an admin to edit a note that they didn't create" do
  		expect(subject).to permit(admin, note_1)
  	end

  	it "doesn't allow a vip to edit a note they don't own" do
  		expect(subject).to_not permit(vip, note_1)
  	end
  end

  permissions :destroy? do
  	it "denies ability to delete a post you don't own" do
  		expect(subject).to_not permit(current_user, note_2)
  	end

  	it "allows user to delete their own post" do 
  		expect(subject).to permit(current_user, note_1)
  	end

  	it "allows an admin to delete a note that they didn't create" do
  		expect(subject).to permit(admin, note_1)
  	end

  	it "doesn't allow a vip to delete a note they don't own" do
  		expect(subject).to_not permit(vip, note_1)
  	end
  end

  permissions ".scope" do
  	it "allows users to see posts they created" do
  		expect(NotePolicy::Scope.new(current_user, scope).resolve).to eq [note_1]
  	end

  	it "doesn't show posts a user didn't create" do
  		expect(NotePolicy::Scope.new(other_user, scope).resolve).to eq []
  	end

  	it "allows an admin to see all posts" do
  		expect(NotePolicy::Scope.new(admin, scope).resolve).to eq [note_1, note_2, note_3]
  	end
  end

  permissions :show? do

  	it "allows user to see posts they've created" do
  		expect(subject).to permit(current_user, note_1)
  	end

  	it "doesn't allow a user to see posts they don't own" do
  		expect(subject).to_not permit(other_user, note_1)
  	end

  	it "allows vip to see any post" do
  		expect(subject).to permit(vip, note_1)
  	end

  	it "allows a user to see a post they're a reader of" do
  		note_2.readers << current_user
  		expect(subject).to permit(current_user, note_2)
  	end
  end












end





