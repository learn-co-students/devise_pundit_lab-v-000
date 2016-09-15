describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:mod) { FactoryGirl.build_stubbed :user, :mod}
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:note) { Note.new(content: "Blahblab", user_id: current_user.id) }

  permissions :create?, :update?, :show?, :destroy?, :add_viewers?, :remove_viewers? do
    it "denies if not an admin or the owner of the note" do
      expect(NotePolicy).not_to permit(other_user, note)
    end
    it "allows if an admin" do
      expect(NotePolicy).to permit(admin, note)
    end
    it "allows if the owner of the note" do
      expect(NotePolicy).to permit(current_user, note)
    end
  end

  permissions :index? do
    it "denies access to normal users" do
      expect(subject).not_to permit(current_user, note)
    end
    it "allows access if admin" do
      expect(subject).to permit(admin, note)
    end
    it "allows access if mod" do
      expect(subject).to permit(mod, note)
    end
  end


end
