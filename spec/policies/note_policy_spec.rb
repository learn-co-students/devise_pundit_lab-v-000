describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }

  permissions :create? do
    it "allows you to create your own notes" do
        expect(NotePolicy).to permit(current_user, current_user)
    end
    it "allows admin to create your notes" do
        expect(NotePolicy).to permit(admin)
    end
  end

  permissions :edit? do
    it "allows you to edit your own notes" do
        expect(NotePolicy).to permit(current_user, current_user)
    end
    it "allows admin to edit your notes" do
        expect(NotePolicy).to permit(admin)
    end
  end

  permissions :destroy? do
    it "allows you to delete your own notes" do
      expect(subject).to permit(current_user, current_user)
    end
    it "allows an admin to delete any note" do
      expect(subject).to permit(admin, other_user)
    end
  end

  permissions :index? do
    it "allows access to your own notes" do
      expect(NotePolicy).to permit(current_user, current_user)
    end
    it "denies access if not an admin" do
      expect(NotePolicy).not_to permit(current_user, other_user)
    end
    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
    it "allows access for moderators" do
      expect(NotePolicy).to permit(moderator)
    end
  end

  permissions :show? do
    it "prevents other users from seeing your note" do
      expect(subject).not_to permit(current_user, other_user)
    end
    it "allows you to see your own note" do
      expect(subject).to permit(current_user, current_user)
    end
    it "allows an admin to see any note" do
      expect(subject).to permit(admin)
    end
    it "allows moderators to see any note" do
      expect(subject).to permit(moderator)
    end
  end

  permissions :update? do
    it "prevents others from updating your note" do
      expect(subject).not_to permit(current_user, other_user)
    end
    it "allows you to update your note" do
      expect(subject).to permit(current_user, current_user)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin)
    end
  end

end
