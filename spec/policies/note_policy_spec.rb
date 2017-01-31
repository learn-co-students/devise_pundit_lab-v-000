describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  
  let (:unshared_note) { FactoryGirl.build_stubbed :unshared_note }
  let (:shared_note) { FactoryGirl.build_stubbed :shared_note }

  permissions :index? do
    it "allows access for the user" do
      expect(NotePolicy).to permit(current_user)
    end
    it "denies access if not the user, moderator or admin" do
      expect(NotePolicy).not_to permit(other_user)
    end
    it "allows access for a moderator" do
      expect(NotePolicy).to permit(moderator)
    end
    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
  end

  permissions :edit? do
    it "allows access for the user" do
      expect(NotePolicy).to permit(current_user)
    end
    it "denies access if not the user or admin" do
      expect(NotePolicy).not_to permit(other_user)
    end
    it "deinies access for a moderator" do
      expect(NotePolicy).not_to permit(moderator)
    end
    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
  end
  
  permissions :destroy? do
    it "allows user to delete own post" do
      expect(subject).to permit(current_user)
    end
    it "prevents other user from deleting post" do
      expect(subject).not_to permit(other_user)
    end
    it "prevents moderator from deleting post" do
      expect(subject).not_to permit(moderator)
    end
    it "allows admin to delete post" do
      expect(subject).to permit(admin)
    end
  end

  permissions :show? do
    it "allows user to delete own post" do
      expect(subject).to permit(current_user)
    end
    it "prevents other user from deleting post" do
      expect(subject).not_to permit(other_user)
    end
    it "prevents moderator from deleting post" do
      expect(subject).not_to permit(moderator)
    end
    it "allows admin to delete post" do
      expect(subject).to permit(admin)
    end
  end
  
  permissions :update? do
    it "allows user to delete own post" do
      expect(subject).to permit(current_user)
    end
    it "prevents other user from deleting post" do
      expect(subject).not_to permit(other_user)
    end
    it "prevents moderator from deleting post" do
      expect(subject).not_to permit(moderator)
    end
    it "allows admin to delete post" do
      expect(subject).to permit(admin)
    end
  end

end
