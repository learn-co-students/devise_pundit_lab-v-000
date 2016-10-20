describe NotePolicy do
  subject { NotePolicy}

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

  permissions :update? do
    it "allows you to edit your own posts" do
      expect(subject).to permit(current_user, current_user)
    end
    it "allows you to add viewers to your own posts" do
      expect(subject).to permit(current_user, current_user)
    end
    it "allows you to remove viewers of your own posts" do
      expect(subject).to permit(current_user, current_user)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it "allows you to delete your own posts" do
      expect(subject).to permit(current_user, current_user)
    end
    it "allows an admin to delete any post" do
      expect(subject).to permit(admin, other_user)
    end
  end

  permissions :show? do
    it "allows you to see notes you're a viewer of" do
      expect(subject).to permit(current_user, current_user)
    end
    it "allows you to see your own notes" do
      expect(subject). to permit(current_user, current_user)
    end
    it "allows a moderator to see all notes" do
      expect(subject).to permit(moderator, note)
    end
    it "allows an admin to see any post" do
      expect(subject).to permit(admin)
    end
  end



end
