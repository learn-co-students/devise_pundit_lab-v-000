describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator}
  let (:note) {FactoryGirl.build_stubbed :note do |note|
                 note.user_id = current_user.id
               end}

  permissions :index? do
    it "denies access if not an admin" do
      expect(NotePolicy).not_to permit(other_user, note)
    end
    it "allows access for an admin" do
      expect(NotePolicy).to permit(admin, note)
    end
     it "allows access for a moderator" do
      expect(NotePolicy).to permit(moderator, note)
    end
  end



  #  permissions :create? do 
  #   it "allows users to create notes owned by them" do
  #     expect(NotePolicy).to permit(current_user, note)
  #   end

  # end

  # permissions :update? do 
  #   it "allows users to edit notes owned by them" do
  #     expect(NotePolicy).to permit(current_user, note)
  #   end
  # end

  # permissions :destroy? do
  #   it "allows users to delete notes owned by them" do
  #     expect(NotePolicy).to permit(current_user, note)
  #   end
  # end

  # permissions :add_viewers? do
  #   it "allows users to add or remove viewers to notes owned by them" do
  #     expect(NotePolicy).to permit(current_user, note)
  #   end
  # end

  # permissions :see_notes? do
  #   it "allows users to add or remove viewers to notes owned by them" do
  #     expect(NotePolicy).to permit(current_user, note)
  #   end
  # end

  # permission :show? do
  #  it "allows users to add or remove viewers to notes owned by them" do
  #     expect(NotePolicy).to permit(current_user, note)
  #   end
  # end




 end
