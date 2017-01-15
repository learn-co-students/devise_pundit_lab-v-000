describe PostPolicy do
  subject { PostPolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }

  permissions :create?, :update? do
    it "denies create or update if not current user" do
      expect(PostPolicy).not_to permit(current_user, other_user)
    end
    it "allows create or update for current user" do
      expect(PostPolicy).to permit(current_user, current_user)
    end
    it "allows admin to create or update post for other user" do
      expect(PostPolicy).to permit(admin, other_user)
    end

  end

  permissions :destroy? do
    it "allows current user to delete own posts" do
      expect(subject).to permit(current_user, current_user)
    end
    it "allows an admin to delete any post" do
      expect(subject).to permit(admin, other_user)
    end
    it "prevents deleting posts if other user" do
      expect(subject).not_to permit(current_user, other_user)
    end
  end



end
