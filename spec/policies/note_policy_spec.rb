describe NotePolicy do 
  subject { NotePolicy }


  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:vip) {FactoryGirl.build_stubbed :user, :vip } 
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }




  permissions :index? do
    it "denies access if not an admin" do
      expect(NotePolicy).not_to permit(current_user)
    end
    it "allows access for an admin or vip" do
      expect(NotePolicy).to permit(admin, vip)
    end

  end

  permissions :show? do
    it "allows vips, admins, seeing own notes" do
      expect(subject).to permit(admin, current_user)
      expect(subject).to permit(vip, current_user)
      expect(subject).to permit(current_user, current_user)
    end
    it "denies other users from seeing notes" do
      expect(subject).not_to permit(current_user, other_user)
    end

  end

  permissions :create? do 
    it "allows user to create a note owned by them" do
      expect(subject).to permit(current_user, current_user)
    end
    it "denies creation of note not owned by you" do
      expect(subject).not_to permit(current_user, other_user)
    end
  end

  permissions :update? do
    it "prevents updates if not an admin or current user" do
      expect(subject).not_to permit(other_user, vip)
    end
    it "allows self and admin to edit post" do
      expect(subject).to permit(admin, current_user)
      expect(subject).to permit(current_user, current_user)
    end
  end

  permissions :destroy? do
    it "prevents any other user deleting note" do
      expect(subject).not_to permit(other_user, vip)
    end
    it "allows an admin or self to delete post" do
      expect(subject).to permit(admin, current_user)
    end
  end

end