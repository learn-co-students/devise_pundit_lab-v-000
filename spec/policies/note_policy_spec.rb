describe NotePolicy do
  subject { NotePolicy }

  let (:user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:owner) {FactoryGirl.build_stubbed :user }
  let (:note) { FactoryGirl.build_stubbed :note }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  permissions :create do
    it "allows creation of notes owned by them" do
      note.user = owner
      expect(subject).to permit(owner, note)
    end
    it "prevents creation of notes not owned by them" do
      note.user = other_user
      expect(subject).not_to permit(owner, note)
    end
  end

  permissions :update do
    it "allows editing of notes owned by them" do
      note.user = owner
      expect(subject).to permit(owner, note)
    end
    it "prevents editing of notes not owned by them" do
      note.user = other_user
      expect(subject).not_to permit(owner, note)
    end
    it "allows admin to edit notes not owned by them" do
      note.user = other_user
      expect(subject).to permit(admin, note)
    end
  end

  permissions :add_viewer do
    it "allows adding viewers to notes owned by them" do
      note.user = owner
      expect(subject).to permit(owner, note)
    end
    it "prevents adding viewers to notes not owned by them" do
      note.user = other_user
      expect(subject).not_to permit(owner, note)
    end
    it "allows admin to add viewers to notes not owned by them" do
      note.user = other_user
      expect(subject).to permit(admin, note)
    end
  end

  permissions :remove_viewer do
    it "allows removing viewers to notes owned by them" do
      note.user = owner
      expect(subject).to permit(owner, note)
    end
    it "prevents removing viewers to notes not owned by them" do
      note.user = other_user
      expect(subject).not_to permit(owner, note)
    end
    it "allows admin to remove viewers to notes not owned by them" do
      note.user = other_user
      expect(subject).to permit(admin, note)
    end
  end

  permissions :show? do
    it "prevents other users from seeing your note" do
      note.user = other_user
      expect(subject).not_to permit(user, note)
    end
    it "allows you to see your own note" do
      note.user = owner
      expect(subject).to permit(owner, note)
    end
    it "allows an moderator to see any note" do
      expect(subject).to permit(moderator)
    end
    it "allows an admin to see any note" do
      expect(subject).to permit(admin)
    end
  end


  permissions :destroy? do
    it "allows user to delete their own note" do
      note.user = owner
      expect(subject).to permit(owner, note)
    end
    it "prevents deleting of notes not owned by them" do
      note.user = other_user
      expect(subject).not_to permit(owner, note)
    end
    it "allows an admin to delete any note" do
      note.user = other_user
      expect(subject).to permit(admin, note)
    end
  end

end
