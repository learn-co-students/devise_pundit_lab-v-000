describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator}
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  permissions :index? do
    it "denies access if not an admin or moderator" do
      expect(subject).not_to permit(current_user)
    end
    it "allows access for an admin" do
      expect(subject).to permit(admin)
    end
    it "allows access for a mod" do
    	expect(subject).to permit(moderator)
    end
  end

  permissions :show? do
    it "prevents other users from seeing your notes" do
      expect(subject).not_to permit(current_user, other_user)
    end
    it "allows you to see your own notes" do
      expect(subject).to permit(current_user, current_user)
    end
    it "allows an admin to see any notes" do
      expect(subject).to permit(admin)
    end
  end

  permissions :create? do
  	it "prevents other users from creating a note for you" do
  		expect(subject).not_to permit(current_user, other_user)
  	end
  	it "allows you to create your own note" do
  		expect(subject).to permit(current_user, current_user)
  	end
  	it "allows an admin to create a note" do
  		expect(subject).to permit(admin)
  	end
  end

  permissions :update? do
    it "prevents updates if not an admin" do
      expect(subject).not_to permit(current_user)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it "prevents other users from deleting your note" do
      expect(subject).not_to permit(current_user, other_user)
    end
    it "allows you to delete your own note" do
    	expect(subject).to permit(current_user, current_user)
    end
    it "allows an admin to delete any user" do
      expect(subject).to permit(admin, other_user)
    end
  end
end
