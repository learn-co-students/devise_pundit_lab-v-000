describe NotePolicy do
  subject { NotePolicy }

  let (:note_user) { FactoryGirl.build_stubbed :user }
  let (:other_user1) { FactoryGirl.build_stubbed :user }
  let (:other_user2) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:moderator) do
  	User.create({name: "hally", email: "hally@hally.com", role: 1})
  end
  let (:note) do
  		note = Note.new(content: "Ha, ha, ha!")
  		note.user = note_user
  		note.readers << other_user1
  		note.save
  		note
  end

  permissions :edit? do
    it "denies access if not an admin or the creator" do
      expect(NotePolicy).not_to permit(other_user1, note)
      expect(NotePolicy).not_to permit(other_user2, note)
      expect(NotePolicy).not_to permit(moderator, note)
    end
    it "allows access for an admin or the creator" do
      expect(NotePolicy).to permit(admin, note)
      expect(NotePolicy).to permit(note_user, note)
    end
  end

  permissions :update? do
    it "denies access if not an admin or the creator" do
      expect(NotePolicy).not_to permit(other_user1, note)
      expect(NotePolicy).not_to permit(other_user2, note)
      expect(NotePolicy).not_to permit(moderator, note)
    end
    it "allows access for an admin or the creator" do
      expect(NotePolicy).to permit(admin, note)
      expect(NotePolicy).to permit(note_user, note)
    end
  end

  permissions :destroy? do
    it "denies access if not an admin or the creator" do
      expect(NotePolicy).not_to permit(other_user1, note)
      expect(NotePolicy).not_to permit(other_user2, note)
      expect(NotePolicy).not_to permit(moderator, note)
    end
    it "allows access for an admin or the creator" do
      expect(NotePolicy).to permit(admin, note)
      expect(NotePolicy).to permit(note_user, note)
    end
  end

    permissions :show? do
    it "denies access if not an admin a moderator, a reader or the creator" do
      expect(NotePolicy).not_to permit(other_user2, note)
    end
    it "allows access for an admin, moderator, reader, or the creator" do
      expect(NotePolicy).to permit(admin, note)
      expect(NotePolicy).to permit(moderator, note)
      expect(NotePolicy).to permit(other_user1, note)
      expect(NotePolicy).to permit(note_user, note)
    end
  end


end