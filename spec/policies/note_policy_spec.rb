describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:note) { FactoryGirl.build_stubbed :note }

  permissions :create? do
    it "allows user to create notes owned by them" do
      expect(subject).to permit(current_user)
    end
    it "allows an admin to create notes" do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it "allows a user to edit their own notes" do
      expect(subject).to permit(note, current_user)
    end
    it "allows an admin to make updates on any note" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it "allows user to delete their own notes" do
      expect(subject).to permit(note, current_user)
    end
    it "allows an admin to delete any note" do
      expect(subject).to permit(admin)
    end
  end

  # permissions :index? do
  #   it "denies access if not an admin" do
  #     expect(NotePolicy).not_to permit(current_user)
  #   end
  #   it "allows access for an admin" do
  #     expect(NotePolicy).to permit(admin)
  #   end
  # end

  # permissions :show? do
  #   it "prevents other users from seeing your profile" do
  #     expect(subject).not_to permit(current_user, other_user)
  #   end
  #   it "allows you to see your own profile" do
  #     expect(subject).to permit(current_user, current_user)
  #   end
  #   it "allows an admin to see any profile" do
  #     expect(subject).to permit(admin)
  #   end
  # end



end