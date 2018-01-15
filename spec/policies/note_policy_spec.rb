describe NotePolicy do
  subject { UserPolicy }

  let (:content) { FactoryGirl.build_stubbed :note }

  let (:other_user) { FactoryGirl.build_stubbed :user }

  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }
  let (:reader) { FactoryGirl.build_stubbed :user, :reader }


  permissions :create? do
    it "denies access if not an admin or user" do
      expect(NotePolicy).not_to permit(moderator)
      expect(NotePolicy).not_to permit(reader)
      expect(NotePolicy).not_to permit(other_user)
    end
    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
  end

  permissions :show? do
    it "allows an admin, moderator and reader to see any notes" do
      expect(NotePolicy).to permit(admin)
      expect(NotePolicy).to permit(moderator)
      expect(NotePolicy).to permit(reader)
    end
  end

  permissions :update? do
    it "prevents updates if not an admin" do
      expect(NotePolicy).not_to permit(moderator)
      expect(NotePolicy).not_to permit(reader)
    end
    it "allows an admin to make updates" do
      expect(NotePolicy).to permit(admin)
    end
  end

  permissions :destroy? do
    it "prevents deleting note if not admin" do
      expect(NotePolicy).not_to permit(moderator)
      expect(NotePolicy).not_to permit(reader)
    end
    it "allows an admin to delete any note" do
      expect(NotePolicy).to permit(admin)
    end
  end

end
