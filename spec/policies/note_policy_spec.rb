describe NotePolicy do
  subject { NotePolicy }

  let(:current_user) { FactoryGirl.build_stubbed :user }
  let(:note) { FactoryGirl.build_stubbed :note, user_id: current_user.id }
  let(:other_user) { FactoryGirl.build_stubbed :user }
  let(:admin) { FactoryGirl.build_stubbed :user, :admin }
  let(:moderator) { FactoryGirl.build_stubbed :user, :moderator }

  permissions :index? do
    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
    it "allows access for a moderator" do
      expect(NotePolicy).to permit(moderator)
    end
    it "allows access for owner of note" do
      expect(NotePolicy).to permit(current_user)
    end
  end

  permissions :update? do
    it "allows an admin to make updates" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it "prevents deleting yourself" do
      expect(subject).not_to permit(current_user, current_user)
    end
    it "allows an admin to delete any user" do
      expect(subject).to permit(admin, other_user)
    end
  end

end
