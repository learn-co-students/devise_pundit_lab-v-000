# describe NotePolicy do
#   subject { NotePolicy }
#
#   let (:current_user) { FactoryGirl.build_stubbed :user }
#   let (:other_user) { FactoryGirl.build_stubbed :user }
#   let (:mod_user) { FactoryGirl.build_stubbed :user, :moderator }
#   let (:admin) { FactoryGirl.build_stubbed :user, :admin }
#
#   let (:private_notes) {FactoryNote.build_stubbed(user: current_user)}
#   let (:others_notes) {FactoryNote.build_stubbed(user: other_user)}
#   let (:shared_notes) {FactoryNote.build_stubbed(user: current_user).readers << other_user}
#
#   permissions :index? do
#     it "denies access if not an admin" do
#       expect(subject).not_to permit(current_user)
#     end
#     it "allows access for an admin" do
#       expect(subject).to permit(admin)
#     end
#   end
#
#
# # Normal users can:
# # Create notes owned by them
# # Edit their own posts
# # Delete their own posts
# # Add viewers to their own posts
# # Remove viewers from their own posts
# # See notes they're viewers of
# # See their own notes
# # Moderators can:
# # See all notes.
# # Admins can:
# # Perform any action on a user or a note.
#
# # test "users can't update others posts" do
# #        amethyst = users(:amethyst)
# #        post = posts(:garnet_private)
# #        expect(post.user).not_to eq(amethyst)
# #        expect(PostPolicy.new(amethyst, post).update?).to be false
# #      end
#
#   permissions :create? do
#     it "allows the creation of notes by users" do
#       expect(subject).to permit(current_user)
#     end
#   end
#
#
#   permissions :show? do
#     it "prevents other users from seeing your notes if they are not shared" do
#       expect(subject).not_to permit(other_user, private_notes)
#     end
#     it "allows you to see your own notes" do
#       expect(subject).to permit(current_user, current_user)
#     end
#     it "allows an admin to see any note" do
#       expect(subject).to permit(admin)
#     end
#     it "allows a mod to see any note" do
#       expect(subject).to permit(mod_user)
#     end
#     it "allows you to see shared notes" do
#       expect(subject).to permit(current_user, shared_user)
#     end
#   end
#
#   permissions :update? do
#     it "prevents updates if not an admin" do
#       expect(subject).not_to permit(current_user)
#     end
#     it "allows you to edit your own notes" do
#       expect(subject).to permit(current_user, current_user)
#     end
#     it "prevents you from editing your others notes" do
#       expect(subject).not_to permit(current_user, other_user)
#     end
#     it "allows an admin to make updates" do
#       expect(subject).to permit(admin)
#     end
#   end
#
#   permissions :destroy? do
#     it "allows you to deleting your own notes" do
#       expect(subject).not_to permit(current_user, current_user)
#     end
#     it "allows an admin to delete any user" do
#       expect(subject).to permit(admin, other_user)
#     end
#   end
#
# end
