describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }
  let (:note) { FactoryGirl.build_stubbed :note }

  permissions :create? do
    it "allows access for users and admin" do
      note.user_id = current_user.id
      expect(subject).to permit(current_user, note)
      expect(subject).to permit(admin, note)
    end
    it "denies access for moderators creating notes for other users" do
      note.user_id = current_user.id
      expect(subject).not_to permit(moderator, note)
    end
  end

  permissions :index? do
    it "denies access if not an admin or moderator" do
      expect(subject).not_to permit(current_user)
    end
    it "allows access for a moderator or admin" do
      expect(subject).to permit(admin)
      expect(subject).to permit(moderator)
    end
  end

  permissions :show? do
    it "prevents other users from seeing your notes unless they are viewers" do
      note.user_id = current_user.id
      expect(subject).not_to permit(other_user, note)
    end
    it "allows you to see your own notes" do
      note.user_id = current_user.id
      expect(subject).to permit(current_user, note)
    end
    it "allows an admin or moderator to see any note" do
      note.user_id = current_user.id
      expect(subject).to permit(admin, note)
      expect(subject).to permit(moderator, note)
    end
  end

  permissions :update? do
    it "prevents updates if not owner or admin" do
      note.user_id = current_user.id
      expect(subject).not_to permit(other_user, note)
      expect(subject).not_to permit(moderator, note)
    end
    it "allows an admin or owner to make updates" do
      note.user_id = current_user.id
      expect(subject).to permit(current_user, note)
      expect(subject).to permit(admin, note)
    end
  end

  permissions :destroy? do
    it "allows you to delete your own notes" do
      note.user_id = current_user.id
      expect(subject).to permit(current_user, note)
    end
    it "does not allow other users or moderators to delete your notes" do
      note.user_id = current_user.id
      expect(subject).not_to permit(other_user, note)
      expect(subject).not_to permit(moderator, note)
    end
    it "allows an admin to delete any note" do
      note.user_id = current_user.id
      expect(subject).to permit(admin, note)
    end
  end

end
