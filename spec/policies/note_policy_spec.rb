describe NotePolicy do
  subject { NotePolicy }

  let (:guest) {User.new(email: "guest@email.com")}
  let (:current_user) { FactoryGirl.build_stubbed :user}
  let (:other_user) { FactoryGirl.build_stubbed :user}
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:vip) {FactoryGirl.build_stubbed :user, :vip}

  let (:current_note) {Note.create(content: "current user's note", user: current_user)}
  let (:other_note) {Note.create(content: "other user's note", user: other_user)}
  let (:vipnote1) {Note.create(content: "vip's first note", user: vip)}
  let (:vipnote2) {Note.create(content: "vip's second note", user: vip)}
  let (:adminnote1) {Note.create(content: "admin's first note", user: admin)}
  let (:adminnote1) {Note.create(content: "admin's first note", user: admin)}
 ##each of these users writes 1 note w/no other readers
 ##VIP has second note with current as reader 
 ##Admin has second note with other as reader
 ##so: current has 2 notes (1 written, vip_note as reader)
 ##    other has 2 notes (1 written, admin_note as reader)
 ##    admin & vip can each see 6 notes


  permissions :index? do

    ## Admin & VIP can see all
    ## User can see only its own readables (have controller redirect 
    ##  user to users#show action)
    ## --For the user scenario, make sure page displays user's name and all notes
    ## --Rewrite user#show view to display notes(add policy check to be sure)

    it "denies access if not signed in" do
      expect(NotePolicy).not_to permit(guest)
    end

    it "redirects users without privileges" do 
      expect(NotePolicy).not_to permit(guest)
    end

    it "allows access for an admin or vip" do
      expect(NotePolicy).to permit(admin)
      expect(NotePolicy).to permit(vip)
    end
  end

  permissions :new? do
    
    it "denies access if not signed in" do
      expect(subject).not_to permit(guest, Note.new)
    end
  end

  permissions :show? do

    it "denies access if not signed in" do
      expect(subject).not_to permit(guest, current_note)
    end

    it "shows users their notes and readables" do 
      vipnote2.readers << current_user

      expect(subject).to permit(current_user, current_note)
      expect(subject).to permit(current_user, vipnote2)
    end

    it "doesn't let users read notes that aren't readable to them" do
# byebug
      expect(subject).not_to permit(other_user, vipnote2)
      
      expect(subject).not_to permit(other_user, current_note)
    end

    it "lets vips see all notes" do
      expect(subject).to permit(vip, other_note)
      expect(subject).to permit(vip, current_note)
      expect(subject).to permit(vip, adminnote1)
    end

    it "lets admins see all notes" do
      expect(subject).to permit(admin, other_note)
      expect(subject).to permit(admin, current_note)
      expect(subject).to permit(admin, adminnote1)
    end
  end


  permissions :update? do
    it "prevents updates if not an admin" do
      expect(subject).not_to permit(guest)
      expect(subject).not_to permit(current_user)
      expect(subject).not_to permit(other_user)
      expect(subject).not_to permit(vip)
    end

    it "allows an admin to make updates" do
      expect(subject).to permit(admin)
    end

  end
 
  permissions :destroy? do
    
    it "prevents non-admins from deleting notes they didn't write" do
      expect(subject).not_to permit(current_user, vipnote2)
      expect(subject).not_to permit(vip, other_note)
    end

    it "allows users to delete their own notes" do
      expect(subject).to permit(other_user, other_note)
    end

    it "allows an admin to delete any note" do
      expect(subject).to permit(admin, other_note)
    end

  end


end
