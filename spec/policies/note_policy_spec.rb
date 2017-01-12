describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  permissions :index? do
    it "denies access if not admin or modeator" do
      expect(NotePolicy).not_to permit (current_user)
    end    
    it "allows access to moderator and admin" do
      expect(NotePolicy).to permit(moderator, admin)
    end
  end
end
