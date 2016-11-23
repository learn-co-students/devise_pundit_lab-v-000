describe NotePolicy do
  subject { NotePolicy }

  before(:each) do
    @user = User.new(confirmed_at: Time.now, name: "test", email: 'user@example.com', password: "passwordy")
    @note = Note.new(content: "some content")
    @other_note = Note.new(content: "invisible content")
    @note.readers << @user
  end

  let (:vip) { FactoryGirl.build_stubbed :user, :vip}
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  permissions :index? do
    it "allows access if not an admin" do
      expect(NotePolicy).to permit(@user)
    end
    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
  end

  permissions :show? do
    it "allows you to see a note that you are a viewer of" do
      expect(subject).to permit(@user, @note)
    end
    it "doesn't allow you to see a note that you're not a viewer of" do
      expect(subject).not_to permit(@user, @other_note)
    end
    it "allows an admin to see any note" do
      expect(subject).to permit(vip, @note)
    end
    it "allows an admin to see any note" do
      expect(subject).to permit(admin, @other_note)
      expect(subject).to permit(admin, @other_note)
    end
  end

  permissions :update? do
    it "allows you to update your own note" do
      expect(subject).to permit(@user, @note)
    end
    it "prevents updates of notes that don't belong to you" do
      expect(subject).not_to permit(@user, @other_note)
    end
    it "prevents updates if a moderator" do
      expect(subject).not_to permit(vip, @note)
    end
    it "allows an admin to make updates" do
      expect(subject).to permit(admin, @note)
      expect(subject).to permit(admin, @other_note)
    end
  end

  permissions :destroy? do
    it "allows you to delete your own note" do
      expect(subject).to permit(@user, @note)
    end
    it "doesn't allow you to delete other people's notes" do
      expect(subject).not_to permit(@user, @other_note)
    end
    it "doesn't allow vips to delete other people's notes" do
      expect(subject).not_to permit(vip, @note)
    end
    it "allows an admin to delete any note" do
      expect(subject).to permit(admin, @note)
      expect(subject).to permit(admin, @other_note)
    end
  end

end
