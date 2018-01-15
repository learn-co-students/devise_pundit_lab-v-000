describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  permissions :create? do
    it "denies access if not current user or admin" do
      expect(NotePolicy).not_to permit(other_user)
    end
    it "allows access for an admin and current user" do
      expect(NotePolicy).to permit(admin, current_user)
    end
  end

  #permissions :show? do
  #  it "prevents other users from seeing your notes unless they are viewers" do
  #    expect(subject).not_to permit(current_user, other_user)
  #  end
  #  it "allows you to see your own profile" do
  #    expect(subject).to permit(current_user, current_user)
  #  end
  #  it "allows an admin to see any profile" do
  #    expect(subject).to permit(admin)
  #  end
  #end

  permissions :update? do
    it "prevents updates if not an admin or current user" do
      expect(subject).not_to permit(other_user)
    end
    it "allows an admin and current user to make updates" do
      expect(subject).to permit(admin, current_user)
    end
  end

  permissions :destroy? do
    it "prevents deleting other users notes" do
      expect(subject).not_to permit(other_user)
    end
    it "allows an admin or the current user to delete their note" do
      expect(subject).to permit(admin, current_user)
    end
  end

end
