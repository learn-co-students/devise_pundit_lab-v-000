describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  permissions :create? do
    it "denies access if neither admin nor owner" do
      expect(subject).not_to permit(current_user, Note.new(user: other_user))
    end
    it "allows access for an admin" do
      expect(subject).to permit(admin, Note.new(user: other_user))
    end
    it "allows access for the owner of a note" do
      expect(subject).to permit(current_user, Note.new(user: current_user))
    end
  end

  permissions :update? do
    it "prevents updates if neither admin nor owner" do
      expect(subject).not_to permit(current_user, Note.new(user: other_user))
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin, Note.new(user: other_user))
    end
    it "allows owner to make updates" do
      expect(subject).to permit(current_user, Note.new(user: current_user))
    end
  end

  permissions :destroy? do
    it "prevents deleting notes if neither admin nor owner" do
      expect(subject).not_to permit(current_user, Note.new(user: other_user))
    end
    it "allows an admin to delete notes" do
      expect(subject).to permit(admin, Note.new(user: other_user))
    end
    it "allows owner to delete notes" do
      expect(subject).to permit(current_user, Note.new(user: current_user))
    end
  end

end
