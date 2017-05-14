describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:owner) {FactoryGirl.build_stubbed :user }
  let (:note) { FactoryGirl.build_stubbed :note }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }

  permissions :new? do
    it "allows users to create notes" do
      note.user = owner 
      expect(subject).to permit(owner, note)
    end

    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
  end

  permissions :update? do
    it "allows users to edit their own notes" do
      note.user = owner 
      expect(subject).to permit(owner, note)
    end

    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
  end


  permissions :delete? do
    it "allows users to delete their own notes" do
      note.user = owner 
      expect(subject).to permit(owner, note)
    end

    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
  end


  permissions :add_reader? do
    it "allows users to add viewers to own notes" do
      note.user = owner 
      expect(subject).to permit(owner, note)
    end

    it "prevents users from adding viewers to other users notes" do 
      note.user = other_user 
      expect(subject).not_to permit(owner, note)
    end 

    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end

  end

  permissions :remove_reader? do
    it "allows users to remove viewers to own notes" do
      note.user = owner 
      expect(subject).to permit(owner, note)
    end

    it "prevents users from removing viewers to other users notes" do 
      note.user = other_user 
      expect(subject).not_to permit(owner, note)
    end 

    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin)
    end
  end

  permissions :show? do 
    it "allows user to see own notes" do 
      note.user = owner
      expect(subject).to permit(owner, note)
    end

    it 'allows you to see notes you are a reader of' do
      note.readers << other_user
      expect(subject).to permit(other_user, note)
    end
  end 
end
