# describe NotePolicy do
#   subject { NotePolicy }
#
#   let (:current_user) { FactoryGirl.build_stubbed :user }
#   let (:other_user) { FactoryGirl.build_stubbed :user }
#   let (:moderator) { FactoryGirl.build_stubbed :user, :moderator }
#   let (:admin) { FactoryGirl.build_stubbed :user, :admin }
# #  let (:note1) {FactoryGirl.build_stubbed :note, }
#
#   permissions :index? do
#     it "allows a user to see own notes" do
#       expect(NotePolicy).to permit(current_user.id, note1.user_id)
#     end
#     it "allows a user to see notes they're viewers of" do
#       expect(NotePolicy).to permit(current_user, Note.)
#     end
#     it "allows a moderator to see all notes" do
#       expect(NotePolicy).to permit(moderator)
#     end
#     it "allows an admin to see all notes" do
#       expect(NotePolicy).to permit(admin)
#     end
#   end
#
#   permissions :show? do
#     it "user can see own note" do
#       expect(subject).not_to permit(current_user, other_user)
#     end
#     it "user can see note they're a viewer of" do
#       expect(subject).to permit(current_user, current_user)
#     end
#     it "allows a moderator to see all notes" do
#       expect(subject).to permit(admin)
#     end
#     it "allows an admin to see all notes" do
#       expect(subject).to permit(admin)
#     end
#   end
#
#   permissions :update? do
#     it "allows user to update own notes" do
#       expect(subject).not_to permit(current_user)
#     end
#     it "allows an admin to make updates" do
#       expect(subject).to permit(admin)
#     end
#   end
#
#   permissions :destroy? do
#     it "allows user to destroy own notes" do
#       expect(subject).not_to permit(current_user, current_user)
#     end
#     it "allows an admin to delete any note" do
#       expect(subject).to permit(admin, other_user)
#     end
#   end
#
# end
