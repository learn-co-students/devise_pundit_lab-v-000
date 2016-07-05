describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:note) { FactoryGirl.build_stubbed :note }

  permissions :show? do
    it "allows you to see your own note" do
      note.user = current_user
      expect(subject).to permit(current_user, note)
    end
    it "allows an admin to see any note" do
      expect(subject).to permit(admin)
    end
    it "allows a vip to see any note" do
      expect(subject).to permit(admin)
    end
  end

  permissions :create? do
    it "allows user to create notes" do 
      expect(subject).to permit(current_user, note)
    end
  end

  permissions :edit? do
    it "allows user to edit their own notes" do 
      note.user = current_user
      expect(subject).to permit(current_user, note)
    end
    it "does not allow users to edit notes of others" do 
      expect(subject).not_to permit(current_user, note)
    end
    it "allows an admin to edit any note" do
      expect(subject).to permit(admin, note)
    end
  end

  permissions :destroy? do
    it "allows user to destroy notes created by them" do 
      note.user = current_user
      expect(subject).to permit(current_user, note)
    end
    it "does not allow a user to destroy notes created by others" do 
      expect(subject).to_not permit(current_user, note)
    end
    it "allows an admin to destroy any note" do
      expect(subject).to permit(admin, note)
    end
  end

end