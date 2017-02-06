describe NotePolicy do
  subject { NotePolicy }

  let (:current_user) { FactoryGirl.build_stubbed :user }
  let (:other_user) { FactoryGirl.build_stubbed :user }
  let (:admin) { FactoryGirl.build_stubbed :user, :admin }

  permissions :create? do
    it 'allows access for user' do
      @note = current_user.notes.create(content: "Hello")
      expect(subject).to permit(current_user, @note)
    end

    it 'allows access for admins' do
      @note = current_user.notes.create(content: "Hello")
      expect(subject).to permit(admin, @note)
    end
  end

  permissions :edit? do
    it 'allows access for user' do
      @note = current_user.notes.create(content: "Hello")
      expect(subject).to permit(current_user, @note)
    end

    it 'prevents access for other users' do
      @note = current_user.notes.create(content: "Hello")
      expect(subject).not_to permit(other_user, @note)
    end

    it 'allows access for admins' do
      @note = current_user.notes.create(content: "Hello")
      expect(subject).to permit(admin, @note)
    end
  end

  permissions :delete? do
    it 'allows access for user' do
      @note = current_user.notes.create(content: "Hello")
      expect(subject).to permit(current_user, @note)
    end

    it 'prevents access for other users' do
      @note = current_user.notes.create(content: "Hello")
      expect(subject).not_to permit(other_user, @note)
    end

    it 'allows access for admins' do
      @note = current_user.notes.create(content: "Hello")
      expect(subject).to permit(admin, @note)
    end
  end

  permissions :show? do
    it 'allows access for user' do
      @note = current_user.notes.create(content: "Hello")
      expect(subject).to permit(current_user, @note)
    end

    it 'prevents access for other users' do
      other_user = build(:user)
      other_user.email = "new@example.com"
      other_user.save

      @note = current_user.notes.create(content: "Hello")
      expect(subject).not_to permit(other_user, @note)
    end

    it 'allows access for readers' do
      other_user = build(:user)
      other_user.email = "new@example.com"
      other_user.save

      @note = current_user.
        notes.create(content: "Hello",
                     visible_to: other_user.email)

      expect(subject).to permit(other_user, @note)
    end

    it 'allows access for admins' do
      @note = current_user.notes.create(content: "Hello")
      expect(subject).to permit(admin, @note)
    end
  end



end

# See notes they're viewers of
# See their own notes
# Admins can:
# Perform any action on a user or a note.

