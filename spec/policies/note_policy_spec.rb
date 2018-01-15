describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  permissions :show? do
    it "allows reader to see note" do

      expect(subject).to permit(admin)
    end
    it "allows an admin to see any note" do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it "prevents updates if not an admin or owner" do
      expect(subject).not_to permit(other_user)
    end
    it "allows an admin or owner to make updates" do
      expect(subject).to permit(admin, current_user)
    end
  end

  permissions :destroy? do
    it "prevents others from deleting" do
      expect(subject).not_to permit(other_user)
    end
    it "allows an admin or owner to delete" do
      expect(subject).to permit(admin, current_user)
    end
  end

end
