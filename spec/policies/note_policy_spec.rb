describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:own_note) { Note.create(content: "my own note", user_id: current_user.id)}

  permissions :create? do
    it "allows you to create your own note" do
      expect(subject).to permit(current_user, own_note)
    end
  end

  # permissions :index? do
  #   it "denies access if not an admin" do
  #     expect(UserPolicy).not_to permit(current_user)
  #   end
  #   it "allows access for an admin" do
  #     expect(UserPolicy).to permit(admin)
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
  #
  # permissions :update? do
  #   it "prevents updates if not an admin" do
  #     expect(subject).not_to permit(current_user)
  #   end
  #   it "allows an admin to make updates" do
  #     expect(subject).to permit(admin)
  #   end
  # end
  #
  # permissions :destroy? do
  #   it "prevents deleting yourself" do
  #     expect(subject).not_to permit(current_user, current_user)
  #   end
  #   it "allows an admin to delete any user" do
  #     expect(subject).to permit(admin, other_user)
  #   end
  # end

end
