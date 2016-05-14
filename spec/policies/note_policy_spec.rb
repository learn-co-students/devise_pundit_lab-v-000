describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:forbidden_user) { FactoryGirl.build_stubbed :user }
  let (:allowed_user) { FactoryGirl.build_stubbed :user }
  let (:guest) { User.new(email: "guest@test.com") }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }
  let (:note) { FactoryGirl.build_stubbed(:note, user: current_user) }

  permissions :create? do
    it "allows user to create notes owned by them" do
      expect(subject).to permit(current_user)
    end
    it "allows an admin to create notes" do
      expect(subject).to permit(admin)
    end
    it "should not allow a moderator to create notes" do
      expect(subject).not_to permit(moderator)
    end
    it "should not allow a guest to create notes" do
      expect(subject).not_to permit(guest)
    end
  end

  permissions :update?, :edit?, :destroy? do
    it "allows a user to edit, update, and destroy their own notes" do
      expect(subject).to permit(current_user, note)
    end
    it "allows an admin to make edits, updates, and destroy on any note" do
      expect(subject).to permit(admin)
    end
    it 'should not allow a user to make edits, updates, and destroy notes they do not own' do
      expect(subject).not_to permit(other_user, note)
    end
    it 'should not allow a moderator to make edits, updates, or destroy notes' do
      expect(subject).not_to permit(moderator, note)
    end
    it 'should not allow a guest to make edits, updates, or destroy notes' do
      expect(subject).not_to permit(guest, note)
    end
  end

  permissions :index? do
    it "allows user to view their own notes" do
      expect(subject).to permit(current_user)
    end
    it "allows admin to view all notes" do
      expect(subject).to permit(admin)
    end
    it "allows moderator to view all notes" do
      expect(subject).to permit(moderator)
    end
  end

  permissions :show? do
    it "prevents users from viewing notes they are not allowed to read" do
      expect(subject).not_to permit(forbidden_user, note)
    end
    it "allows you to view your own note" do
      expect(subject).to permit(current_user, note)
    end
    it "allows you to view notes you are a viewer of" do
      note.readers << allowed_user
      expect(subject).to permit(allowed_user, note)
    end
    it "allows admins to view any note" do
      expect(subject).to permit(admin, note)
    end
    it "allows moderators to view any note" do
      expect(subject).to permit(moderator, note)
    end
    it "should not allow a guest to view notes" do
      expect(subject).not_to permit(guest)
    end
  end



end