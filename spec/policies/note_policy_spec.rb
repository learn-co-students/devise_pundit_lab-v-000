describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:my_note) { Note.new(content: "information", user_id: current_user.id)}
  let (:your_note) { Note.new(content: "information", user_id: moderator.id)}

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
      expect(subject).not_to permit(current_user, your_note)
    end
    it "allows mod to see note" do
      expect(subject).to permit(moderator, your_note)
    end
    it "allows an admin to see any note" do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it "prevents updates if not an admin" do
      expect(subject).not_to permit(current_user, your_note)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin, your_note)
    end
  end

  permissions :destroy? do
    it "prevents deleting another's note" do
      expect(subject).not_to permit(current_user, your_note)
    end
    it "allows an admin to delete any note" do
      expect(subject).to permit(admin, your_note)
    end
  end

end