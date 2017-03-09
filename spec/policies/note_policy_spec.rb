require 'pry'

describe NotePolicy do

  let (:current_user) { FactoryGirl.create :user, name: "current_user", email: "current_user@hotmail.com" }
  let (:other_user) { FactoryGirl.create :user, name: "other_user", email: "other_user@gmail.com" }
  let (:moderator) { FactoryGirl.create :user, :moderator, name: "moderator", email: "moderator@yahoo.fr" }
  let (:admin) { FactoryGirl.create :user, :admin, name: "admin", email: "admin@yahoo.com" }
  let (:note) { FactoryGirl.create :note, user: current_user }
  let (:viewer) { FactoryGirl.create :viewer, user: other_user, note: note}

  permissions :create? do
    it "lets any user create a note" do
      expect(NotePolicy).to permit(current_user)
      expect(NotePolicy).to permit(other_user)
      expect(NotePolicy).to permit(admin)
    end 
    it "assigns ownership of a note to its creator" do
      expect(note.user).to eq(current_user)
    end
  end
  
  permissions :show? do 
    it "lets a user add a viewer to her post" do
      note.viewers << viewer
      note.reload
      expect(note.readers).to include(other_user)
    end
    it "lets a user remove a viewer from her post" do 
      viewer.delete
      note.reload
      expect(note.readers).not_to include(other_user)
    end
    it "lets you see your own fine work" do 
      expect(NotePolicy).to permit(current_user, note)
    end
    it "doesn't let any old pleb view your post" do
      expect(NotePolicy).not_to permit(other_user, note)
    end
    it "lets a moderator view your post, like it or not" do
      expect(NotePolicy).to permit(moderator, note)
    end
    it "lets an admin have a look" do
      expect(NotePolicy).to permit(admin, note)
    end
    it "lets a user see notes of which she's a viewer" do 
      note.viewers << viewer
      note.reload
      expect(NotePolicy).to permit(other_user, note)
    end
  end

  permissions :index? do
    it "permits moderator" do
      expect(NotePolicy).to permit(moderator)
    end
    it "permits admin" do
      expect(NotePolicy).to permit(admin)
    end
    it "rejects normal users" do
      expect(NotePolicy).not_to permit(current_user)
    end
  end

  permissions :update? do
    it "permits admin to update any note" do
      expect(NotePolicy).to permit(admin, note)
    end
    it "permits author to update her own note" do
      expect(NotePolicy).to permit(current_user, note)
    end
    it "doesn't let anyone else update the note" do
      expect(NotePolicy).not_to permit(other_user, note)
      expect(NotePolicy).not_to permit(moderator, note)
    end
  end

  permissions :destroy? do
    it "permits admin to delete any note" do
      expect(NotePolicy).to permit(admin, note)
    end
    it "permits author to delete her own note" do
      expect(NotePolicy).to permit(current_user, note)
    end
    it "doesn't let anyone else delete the note" do
      expect(NotePolicy).not_to permit(other_user, note)
      expect(NotePolicy).not_to permit(moderator, note)
    end
  end

end
