describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  # let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }
  let (:note) { FactoryGirl.build_stubbed :note }

  permissions :show? do
    it "doesn't allow note access if not an admin" do
      expect(NotePolicy).not_to permit(current_user)
    end
    it "doesn't allow note access if not a note owner" do
      expect(NotePolicy).not_to permit(current_user, note)
    end
    it "allows any note access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
    it "allows note access for a note owner to see own notes" do
      note.user = current_user
      expect(subject).to permit(current_user, note)
    end
  end


  permissions :create? do
    it "allows note owner to create their note" do
      note.user = current_user
      expect(subject).to permit(current_user, note)
    end
  end

  permissions :update? do
    ## viewers is a field in the form
    # Add viewers to their own posts
    # Remove viewers from their own posts
    # See notes they're viewers of
    it "prevents updates if not note owner" do
      expect(subject).not_to permit(current_user, note)
    end
    it "allows note owners to update their own notes" do
      note.user = current_user
      expect(subject).to permit(current_user, note)
    end
    it "allows an admin to make updates to any note" do
      expect(subject).to permit(admin, note)
    end
  end

  permissions :destroy? do
      it "allows  users to delete their own notes" do
        note.user = current_user
      expect(subject).to permit(current_user, note)
    end
    it "allows an admin to delete any note" do
      expect(subject).to permit(admin, note)
    end
  end

end

