describe NotePolicy do
  subject { NotePolicy }

  before(:each) do
    @user = User.new(confirmed_at: Time.now, name: "test", email: 'user@example.com', password: 'pass32')
    @note = Note.new(content: "content here.")
    @other_note = Note.new(content: "You shouldn't see this.")
    @note.readers << @user
  end

  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  permissions :index? do
    it "denies access if not an admin" do
      expect(NotePolicy).not_to permit(@user)
    end
    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
  end

  permissions :show? do
    it "allows you to see a note you're a viewer of" do
      expect(subject).to permit(@user, @note)
    end
    it "doesn't allow you to see another user's note" do
      expect(subject).not_to permit(@user, @other_note)
    end
    it "allows a moderator to see any post" do
      expect(subject).to permit(moderator, @note)
      expect(subject).to permit(moderator, @other_note)
    end
    it "allows an admin to see any post" do
      expect(subject).to permit(admin, @note)
      expect(subject).to permit(admin, @other_note)
    end
  end

  permissions :update? do
    it "allows user to update their own note" do
      expect(subject).to permit(@user, @note)
    end
    it "prevents a user from updating someone else's note" do
      expect(subject).not_to permit(@user, @other_note)
    end
    it "prevents a moderator from updating someone else's note" do
      expect(subject).not_to permit(moderator, @note)
      expect(subject).not_to permit(moderator, @other_note)
    end
    it "allows an admin to update any note" do
      expect(subject).to permit(admin, @note)
      expect(subject).to permit(admin, @other_note)
    end
  end

  permissions :destroy? do
    it "allows user to delete their own posts" do
      expect(subject).to permit(@user, @note)
    end
    it "allows an admin to delete any post" do
      expect(subject).to permit(admin, @note)
      expect(subject).to permit(admin, @other_note)
    end
  end
end
