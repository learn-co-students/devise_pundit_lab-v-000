describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:note) { FactoryGirl.build_stubbed :note }

  permissions :index? do
    it "denies access if not an admin" do
      expect(NotePolicy).not_to permit(current_user)
    end
    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
  end

  permissions :show? do
    it "prevents other users from seeing your note" do
      expect(subject).not_to permit(other_user, note)
    end
    it "allows you to see your own note" do
      note.user = current_user
      expect(subject).to permit(current_user, note)
    end
    it "allows an admin to see any note" do
      expect(subject).to permit(admin)
    end
  end

  permissions :create? do
    it "allows user to create notes" do
      expect(subject).to permit(current_user, note)
    end
  end

  permissions :update? do
    it "prevents updates if not an admin" do
      expect(subject).not_to permit(current_user)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it "prevents other users from deleting your note" do
      expect(subject).not_to permit(other_user, note)
    end
    it "allows you to delete your own note" do
      note.user = current_user
      expect(subject).to permit(current_user, note)
    end
    it "allows an admin to delete any note" do
      expect(subject).to permit(admin, note)
    end
  end

end
