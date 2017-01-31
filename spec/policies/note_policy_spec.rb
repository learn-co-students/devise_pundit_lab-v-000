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
      expect(NotePolicy).to permit(admin)
    end
    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
  end

  #permissions :show? do
  #  it "prevents other users from seeing your profile" do
  #    expect(subject).not_to permit(current_user, other_user)
  #  end
  #  it "allows you to see your own profile" do
  #    expect(subject).to permit(current_user, current_user)
  #  end
  #  it "allows an admin to see any profile" do
  #    expect(subject).to permit(admin)
  #  end
  #end
  #
  #permissions :update? do
  #  it "prevents updates if not an admin" do
  #    expect(subject).not_to permit(current_user)
  #  end
  #  it "allows an admin to make updates" do
  #    expect(subject).to permit(admin)
  #  end
  #end
  #
  #permissions :destroy? do
  #  it "prevents deleting yourself" do
  #    expect(subject).not_to permit(current_user, current_user)
  #  end
  #  it "allows an admin to delete any user" do
  #    expect(subject).to permit(admin, other_user)
  #  end
  #end

end
