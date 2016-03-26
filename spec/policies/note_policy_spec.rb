describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:vip) { FactoryGirl.build_stubbed :user, :vip}
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let(:note) { FactoryGirl.create(:note, user: current_user) }

  permissions :create? do
    it "create notes owned by them" do
      expect(subject).to permit(current_user, note)
    end
    it "prevents create notes not owned by them" do
      expect(subject).not_to permit(other_user, note)
    end
  end

  permissions :show? do
    it "prevents other users from seeing your profile" do
      expect(subject).not_to permit(other_user, note)
    end
    it "allows vip to see see any note" do
      expect(subject).to permit(vip)
    end
    it "allows an admin to see any note" do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it "prevents updates if not the owner" do
      expect(subject).not_to permit(other_user, note)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it "prevents deleting if not owner" do
      expect(subject).not_to permit(other_user, note)
    end
    it "allows an admin to delete any note" do
      expect(subject).to permit(admin)
    end
  end

end
