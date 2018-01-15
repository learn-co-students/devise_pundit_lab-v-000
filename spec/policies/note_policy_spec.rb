describe NotePolicy do
  subject { NotePolicy }

let (:current_user) { FactoryGirl.build_stubbed :user }
let (:other_user) { FactoryGirl.build_stubbed :user }
let (:admin) { FactoryGirl.build_stubbed :user, :admin }
let (:moderator) {FactoryGirl.build_stubbed :user, :moderator}

  permissions :index? do
    it "denies access if not an admin or user" do
      expect(NotePolicy).not_to permit(moderator)
    end
    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
    it "allows access for a user" do
      expect(NotePolicy).to permit(current_user)
    end
  end

  permissions :show? do
    it "prevents other users from seeing your profile" do
      expect(subject).not_to permit(current_user, other_user)
    end
    it "allows you to see your own profile" do
      expect(subject).to permit(current_user, current_user)
    end
    it "allows an admin to see any profile" do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it "prevents updates if not an admin or user" do
      expect(subject).not_to permit(moderator)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it "prevents others from deleting your notes" do
      expect(subject).not_to permit(moderator, other_user)
    end

  end

end
