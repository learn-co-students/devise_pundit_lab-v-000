describe ViewerPolicy do
  subject { ViewerPolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:own_note) { Note.create(content: "my own note", user: current_user)}
  let (:viewer_1) { Viewer.create(note: own_note, user: current_user)}

  permissions :create? do
    it "allows you to add your own viewer" do
      expect(subject).to permit(current_user, viewer_1)
    end
  end

  permissions :show? do
    it "allows you to see notes they are viewers of" do
      expect(subject).to permit(current_user, viewer_1)
    end
  end

  permissions :delete? do
    it "allows you to remove your own viewers" do
      expect(subject).to permit(current_user, viewer_1)
    end
  end


end
