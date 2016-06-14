describe NotePolicy do
  subject { NotePolicy }

  let (:guest) {User.new(email: "fake@email.gov")}
  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:vip) { FactoryGirl.build_stubbed :user, :vip }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  let (:current_note) {Note.create(content: "current user's note", user: current_user)}
  let (:other_note) {Note.create(content: "other user's note", user: other_user)}
  let (:vipnote1) {Note.create(content: "vip's first note", user: vip)}
  let (:vipnote2) {Note.create(content: "vip's second note", user: vip)}
  let (:adminnote1) {Note.create(content: "admin's first note", user: admin)}
  let (:adminnote2) {Note.create(content: "admin's first note", user: admin)}

  #Permissions
  # => Users for own posts can CRUD, can add/remove viewers and see their own notes and viewable notes
  # => VIPS can see all notes
  # => Admins can do all actions on users and notes

  permissions :index? do
    
    it "doesn't allow guests to see notes index" do
    expect(NotePolicy).not_to permit(guest)
    end

    it "does allow VIPS and Admins to see notes index" do
    expect(NotePolicy).to permit(vip)
    expect(NotePolicy).to permit(admin)
    end
  end  

  permissions :show? do
    it "doesn't allow guests to see secret notes" do
      expect(NotePolicy).not_to permit(guest, current_note)
    end

    it "allows users to see their own notes" do
      expect(NotePolicy).to permit(current_user, current_note)
    end

    it "allows all view access for an admin and a VIP" do
      expect(NotePolicy).to permit(vip, current_note)
      expect(NotePolicy).to permit(vip, other_note)
      expect(NotePolicy).to permit(vip, vipnote1)
      expect(NotePolicy).to permit(vip, vipnote2)
      expect(NotePolicy).to permit(vip, adminnote1)
      expect(NotePolicy).to permit(vip, adminnote2)
      expect(NotePolicy).to permit(admin, current_note)
      expect(NotePolicy).to permit(admin, other_note)
      expect(NotePolicy).to permit(admin, vipnote1)
      expect(NotePolicy).to permit(admin, vipnote2)
      expect(NotePolicy).to permit(admin, adminnote1)
      expect(NotePolicy).to permit(admin, adminnote2)
    end

    it "allows readers to see notes they have permission for" do
      other_note.readers << current_user
      expect(NotePolicy).to permit(current_user, other_note)
    end
  end

  permissions :update? do
    it "prevents a non-admin from updating notes" do
      expect(NotePolicy).not_to permit(guest)
      expect(NotePolicy).not_to permit(current_user)
      expect(NotePolicy).not_to permit(other_user)
      expect(NotePolicy).not_to permit(vip)
    end
  end

  permissions :destroy? do

    it "allows users to delete their own notes" do
      expect(subject).to permit(other_user, other_note)
    end

    it "allows an admin to delete any note" do
      expect(subject).to permit(admin, other_note)
    end
  end


end