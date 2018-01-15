class NotePolicy < ApplicationPolicy
  def create?
    user.admin? || user == record.user
  end

  def show?
    user.admin? || user.moderator? || user.readable.find_by(id: record.id) || user.notes.find_by(id: record.id)
  end

  def update?
    user.admin? || user.notes.find_by(id: record.id)
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.moderator?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end