describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }
  let (:note) { FactoryGirl.build_stubbed :note }

# Users can:
# Create notes owned by them DONE
# Edit their own notes DONE
# Delete their own posts DONE
# See their own notes PENDING


# Add viewers to their own notes 
# Remove viewers from their own notes
    #shouldn't this just be controlled in edit?

# See notes they're viewers of


# VIPs can:
# See all notes. DONE

# Admins can:
# Perform any action on a user or a note.

  # permissions :index? do
  #   it "denies access if not an admin" do
  #     expect(NotePolicy).not_to permit(current_user)
  #   end
  #   it "allows access for an admin" do
  #     expect(NotePolicy).to permit(admin)
  #   end
  # end

  permissions :show? do
    it "allows you to see your own note" do
      note.user = current_user
      expect(subject).to permit(current_user, note)
    end

    it "allows a viewer to see your note" do
      skip "not complete index action also?"
      note.user = current_user
      expect(subject).to permit(current_user, note)
    end

    it "prevents a non-viewer from seeing your note" do
      skip "not complete"
      note.user = current_user
      expect(subject).to permit(current_user, note)
    end

    it "allows an admin to see any note" do
      expect(subject).to permit(admin)
    end

    it "allows an vip to see any note" do
      expect(subject).to permit(admin)
    end
  end

  permissions :create? do
    it "allows user to create notes" do 
      expect(subject).to permit(current_user, note)
    end
  end

  permissions :edit? do
    # skip "not complete"
    it "allows user to edit their own notes" do 
      note.user = current_user
      expect(subject).to permit(current_user, note)
    end
    it "does not allow users to edit notes of others" do 
      expect(subject).not_to permit(current_user, note)
    end

    it "allows an admin to edit any note" do
      expect(subject).to permit(admin, note)
    end
  end

  permissions :destroy? do
    it "allows user to destroy notes created by them" do 
      note.user = current_user
      expect(subject).to permit(current_user, note)
    end

    it "does not allow a user to destroy notes created by others" do 
      expect(subject).to_not permit(current_user, note)
    end

    it "allows an admin to destroy any note" do
      expect(subject).to permit(admin, note)
    end
  end



  # permissions :update? do
  #   it "prevents updates if not an admin" do
  #     expect(subject).not_to permit(current_user)
  #   end
  #   it "allows an admin to make updates" do
  #     expect(subject).to permit(admin)
  #   end
  # end

  # permissions :destroy? do
  #   it "prevents deleting yourself" do
  #     expect(subject).not_to permit(current_user, current_user)
  #   end
  #   it "allows an admin to delete any user" do
  #     expect(subject).to permit(admin, other_user)
  #   end
  # end

end

