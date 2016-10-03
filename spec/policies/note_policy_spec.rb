describe NotePolicy do

  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:note) { current_user.notes.create!(content: "bla") }

  permissions :show? do
    it "denies access if not an admin, owner of the note, or permitted reader" do
      expect(subject).to_not permit(other_user, note)
    end

    it "grants access if note belongs to user" do
      expect(subject).to permit(current_user, note)
    end

    it "grants access if user is included as a note's reader" do
      note.readers << other_user

      expect(subject).to permit(other_user, note)
    end

    it "grants access if user is an admin" do
      expect(subject).to permit(admin, note)
    end
  end

  permissions :new? do
    it "prevents creation from users who aren't owners of the note and non admins" do
      expect(subject).to_not permit(other_user, note)
    end

    it "allows a user to create notes from their page" do
      expect(subject).to permit(current_user, note)
    end
    it "allows an admin to create new notes" do
      expect(subject).to permit(admin, note)
    end
  end

  permissions :update? do
    it "prevents updates from users who aren't owners of the note and non admins" do
      expect(subject).to_not permit(other_user, note)
    end

    it "allows a notes' owner to make updates" do
      expect(subject).to permit(current_user, note)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin, note)
    end
  end

  permissions :destroy? do
    it "prevents deleting from users who aren't owners of the note and non admins" do
      expect(subject).to_not permit(other_user, note)
    end

    it "allows a notes' owner to delete note" do
      expect(subject).to permit(current_user, note)
    end
    it "allows an admin to delete note" do
      expect(subject).to permit(admin, note)
    end
  end

end
