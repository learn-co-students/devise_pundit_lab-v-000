describe NotePolicy do
  subject { NotePolicy }

  let (:allowed_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator}
  let (:note) {Note.create(:content => "THIS IS THE NOTE", :user_id => allowed_user.id)}



  #permissions :create? do
  #  it "allows users to create notes owned by them" do
  #    expect(NotePolicy).to permit(current_user, current_user)
  #  end
  #end

  permissions :update? do
    it "allows users to update notes owned by them" do
      #binding.pry
      expect(NotePolicy).to permit(allowed_user, note)
    end
    it "prevents users from editing other user posts" do
      expect(NotePolicy).not_to permit(other_user, note)
    end
  end

  permissions :destroy? do
    it "allows users to delete their own posts" do
      expect(NotePolicy).to permit(allowed_user, note)
    end
    it "prevents users from deleting other user posts" do
      expect(NotePolicy).not_to permit(other_user, note)
    end
  end


end
