require 'pry'

describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:current_user_note) { Note.new(content: "test content", user_id: current_user.id) }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  #Users can:
  #Create notes owned by them
  permissions :create? do
    it "allows users to create notes owned by them" do
      expect(subject).to permit(current_user, current_user_note)
    end
    it "allows admin to create notes" do
      expect(subject).to permit(admin)
    end
  end

  #Edit their own posts
  permissions :update? do
    it "allows users to update notes owned by them" do
      expect(subject).to permit(current_user, current_user_note)
    end
    it "allows admin to update notes" do
      expect(subject).to permit(admin)
    end
  end

  #Delete their own posts
  permissions :destroy? do
    it "allows users to delete notes owned by them" do
      expect(subject).to permit(current_user, current_user_note)
    end
    it "allows admin to delete notes" do
      expect(subject).to permit(admin)
    end
  end

  #Add viewers to their own posts

  #Remove viewers from their own posts

  #See notes they're viewers of

  #See their own notes

  #VIPs can: see all notes.
  #Admins can: Perform any action on a user or a note.


end
