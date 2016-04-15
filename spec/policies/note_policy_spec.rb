describe NotePolicy do
  subject { NotePolicy }

  build_notes

  # let (:guest) {User.new(email: "guest@email.com")}
  # let (:one_user) { FactoryGirl.build_stubbed :user}
  # let (:another_user) { FactoryGirl.build_stubbed :user}
  # let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  # let (:vip) {FactoryGirl.build_stubbed :user, :vip}

  # let (:one_note) {Note.create(content: "current user's note", user: one_user)}
  # let (:another_note) {Note.create(content: "other user's note", user: another_user)}
  # let (:vipnote1) {Note.create(content: "vip's first note", user: vip)}
  # let (:vipnote2) {Note.create(content: "vip's second note", user: vip)}
  # let (:adminnote1) {Note.create(content: "admin's first note", user: admin)}
  # let (:adminnote1) {Note.create(content: "admin's first note", user: admin)}
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
      expect(subject).not_to permit(guest, one_note)
    end

    it "shows users their notes and readables" do 
      vipnote2.readers << one_user

      expect(subject).to permit(one_user, one_note)
      expect(subject).to permit(one_user, vipnote2)
    end

    it "doesn't let users read notes that aren't readable to them" do
      expect(subject).not_to permit(another_user, vipnote2)
      expect(subject).not_to permit(another_user, one_note)
    end

    it "lets vips see all notes" do
      expect(subject).to permit(vip, another_note)
      expect(subject).to permit(vip, one_note)
      expect(subject).to permit(vip, adminnote1)
    end

    it "lets admins see all notes" do
      expect(subject).to permit(admin, another_note)
      expect(subject).to permit(admin, one_note)
      expect(subject).to permit(admin, adminnote1)
    end
  end


  permissions :update? do
    it "prevents updates if not the owner or admin" do
      expect(subject).not_to permit(guest, one_note)
      expect(subject).to permit(one_user, one_note)
      expect(subject).not_to permit(one_user, another_note)
      expect(subject).to permit(another_user, another_note)
      expect(subject).not_to permit(another_user, vipnote1)
      expect(subject).not_to permit(vip, one_note)
      expect(subject).to permit(vip, vipnote2)

    end

    it "allows an admin to make updates" do
      expect(subject).to permit(admin, vipnote2)
      expect(subject).to permit(admin, vipnote1)
      expect(subject).to permit(admin, one_note)
      expect(subject).to permit(admin, another_note)
    end

  end
 
  permissions :destroy? do
    
    it "prevents non-admins from deleting notes they didn't write" do
      expect(subject).not_to permit(one_user, vipnote2)
      expect(subject).not_to permit(vip, another_note)
    end

    it "allows users to delete their own notes" do
      expect(subject).to permit(another_user, another_note)
    end

    it "allows an admin to delete any note" do
      expect(subject).to permit(admin, another_note)
    end

  end


end
