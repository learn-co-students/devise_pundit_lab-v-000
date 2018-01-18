describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }
  let (:note) {FactoryGirl.build_stubbed :note, :user_owner}
  let (:note_other) {FactoryGirl.build_stubbed :note, :other_owner}

  permissions :create? do
    it "allows normal user to create own post" do
      expect(NotePolicy).to permit(current_user, note)
    end
  end

  permissions :show? do
    it "prevents other users from seeing your note" do
      expect(subject).not_to permit(current_user, note_other)
    end
    it "allows a moderator to see any note" do
      expect(subject).to permit(moderator)
    end
    it "allows an admin to see any note" do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it "prevents updates if not an admin or owner" do
      expect(subject).not_to permit(current_user)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it "prevents deleting someone else's note" do
      expect(subject).not_to permit(current_user, note_other)
    end
    it "allows an admin to delete any note" do
      expect(subject).to permit(admin, note)
    end
  end

end
