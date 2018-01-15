describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }
  let (:other_user_note) { Note.create(user: other_user, readers: [current_user]) }
  let (:current_user_note) { Note.create(user: current_user) }

  permissions :show? do
    it "allows users to see their own notes" do
      expect(subject).to permit(current_user, current_user_note)
    end
    it "allows users to see notes on which they are a veiwer" do
      expect(subject).to permit(current_user, other_user_note)
    end
     it "does not allow users to see notes on which they are not a veiwer" do
       expect(subject).not_to permit(other_user, current_user_note)
     end
     it "allows admins to see any note" do
       expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it "allows normal users to update their own notes" do
      expect(subject).to permit(current_user, current_user_note)
    end
    it "does not allow normal users to update notes belonging to other users" do
      expect(subject).not_to permit(current_user, other_user_note)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it "allows a user to delete their own post" do
      expect(subject).to permit(current_user, current_user_note)
    end
    it "does not allow a user to delete a post by another user" do
      expect(subject).not_to permit(current_user, other_user_note)
    end
    it "allows an admin to delete a post by another user" do
      expect(subject).to permit(admin, other_user_note)
    end
  end

end
