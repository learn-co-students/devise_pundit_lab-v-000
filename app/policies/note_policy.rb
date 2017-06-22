class NotePolicy < ApplicationPolicy

    def show?
        user.moderator? || user.admin? || record.readers.include?(user)
    end

    def update?
        user.admin? || user==record.user
    end

    def destroy?
        user.admin? || user==record.user
    end

end
