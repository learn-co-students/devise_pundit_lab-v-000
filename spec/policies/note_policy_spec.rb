describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:current_note) { FactoryGirl.build_stubbed :note }
  # let (:other_user) { FactoryGirl.build_stubbed :user }
  # let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  user = User.new(role: 0)
  moderator = User.new(role: 1)
  admin = User.new(role: 2)

  note = user.notes.build(content: 'premade note')
  other_note = Note.new(content: 'made by another user')


  # permissions :index? do
  #   it "denies access if not an admin" do
  #     expect(NotePolicy).not_to permit(current_note)
  #   end
  #   it "allows access for an admin" do
  #     expect(NotePolicy).to permit(admin)
  #   end
  # end

  permissions :create? do
    it "creates note owned by them" do
      expect(subject).to permit(user, user.notes.build(content: "Stuff"))
    end
  end

  permissions :edit? do
    it "edit their own posts" do
      expect(subject).to permit(user, note)
    end
  end

  permissions :destroy? do
    it "doesn't let you destroy users owned by others" do
      expect(subject).not_to permit(user, other_note)
    end
    it "lets you destroy posts the user owns" do
      #only permit if the note is owned by the user
      expect(subject).to permit(user, note)
    end
    it "if admin, can delete any post" do 
      expect(subject).to permit(admin, note)
    end
  end




end
