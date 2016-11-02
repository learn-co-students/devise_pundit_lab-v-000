describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.create :user }
  let (:other_user) { FactoryGirl.create :user, :email => 'other@gmail.com', :name => 'Other User' }
  let (:viewer_user) { FactoryGirl.create :user, :email => 'viewer@gmail.com', :name => 'Viewer User' }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator}
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:note) { FactoryGirl.build_stubbed :note, user_id: current_user.id, visible_to: viewer_user.name }
  let (:other_user_note) { FactoryGirl.create :note, user_id: other_user.id }
  let (:visible_notes) { [note] }
  let (:all_notes) { [note, other_user_note] }

  permissions :index? do
    context "visible notes" do
      it "allows a user to see notes that are visible to them" do
        expect(subject).to permit(viewer_user, visible_notes)
      end
    end

    context "all notes" do 
      it "denies access if not an admin or a moderator" do
        expect(subject).not_to permit(current_user, all_notes)
      end

      it "allows access for an admin" do
        expect(subject).to permit(admin, all_notes)
      end

      it "allows access for a moderator" do
        expect(subject).to permit(moderator, all_notes)
      end
    end
  end

  permissions :show? do
    it "prevents other users from seeing your notes if they are not viewers" do
      expect(subject).not_to permit(other_user, note)
    end

    it "allows you to see your own notes" do
      expect(subject).to permit(current_user, note)
    end

    it "allows a viewer of one of your notes to see that note" do
      expect(subject).to permit(viewer_user, note)
    end

    it "allows an admin to see any note" do
      expect(subject).to permit(admin)
    end

    it "allows a moderator to see any note" do
      expect(subject).to permit(moderator)
    end
  end

  permissions :update? do
    it "prevents updates to a note by normal users who do not own that note" do
      expect(subject).not_to permit(other_user, note)
    end

    it "prevents updates to a note by moderators" do
      expect(subject).not_to permit(moderator, note)
    end

    it "allows an admin to make updates" do
      expect(subject).to permit(admin, note)
    end
  end

  permissions :destroy? do
    it "allows you do delete your own notes" do
      expect(subject).to permit(current_user, note)
    end

    it "does not allow other users to delete your notes" do
      expect(subject).not_to permit(other_user, note)
    end

    it "does not allow a moderator to delete your notes" do
      expect(subject).not_to permit(moderator, note)
    end

    it "allows an admin to delete any note" do
      expect(subject).to permit(admin, note)
    end
  end

end
