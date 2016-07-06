describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:note1) { current_user.notes.build(content: "my note") }
  let (:note2) { other_user.notes.build(content: "not my note") }
  let (:note3) { other_user.notes.build(content: "shared note") }

  # permissions :index? do
    
  #   it "allows access for an admin" do
  #     expect(UserPolicy).to permit(admin)
  #   end
  # end

  permissions :show? do
    it "prevents other users from seeing your notes" do
      expect(subject).not_to permit(other_user, note1)
    end
    it "allows you to see your own notes" do
      expect(subject).to permit(current_user, note1)
    end
    it "allows access to other viewers of the note" do
      note3 = current_user.readable.build(content: "shared note")
      
      expect(subject).to permit(current_user, note3)
    end
    it "allows an admin to see any notes" do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it "prevents updates of another user's posts" do
      expect(subject).not_to permit(current_user, note2)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it "allows users to delete their own notes" do
      expect(subject).to permit(current_user, note1)
    end
    it "doesn't allow other users to delete your notes" do 
       expect(subject).not_to permit(other_user, note1) 
    end
    it "allows an admin to delete any note" do
      expect(subject).to permit(admin, other_user)
    end
  end

end
