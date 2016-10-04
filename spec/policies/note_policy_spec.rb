describe NotePolicy do 
  subject { NotePolicy }

  let (:current_note) { FactoryGirl.build_stubbed :note }
  let (:other_note) {FactoryGirl.build_stubbed :note }
  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  permissions :index? do 
    it "denies access if not an admin" do 
      expect(NotePolicy).not_to permit(current_user)
    end
    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
  end


  



=begin
    it "prevents other users from seeing your notes" do
      note = Note.new(user: other_user)
      expect(note).not_to permit(current_user)
    end
    it "allows you to see your own profile" do
      expect(scope).to permit(current_user, current_user)
    end
    it "allows an admin to see any profile" do 
      expect(scope).to permit(admin)
    end
  end
=end

end