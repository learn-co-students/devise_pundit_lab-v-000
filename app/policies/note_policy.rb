class NotePolicy < ApplicationPolicy

  def create?
    true
  end

  def update?
    user.admin? || record.user == user
  end

  def destroy?
    user.admin? || record.user == user
  end

  def show?
    user.admin? || user.moderator? || record.readers.include?(user)
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.joins(:viewers).where(viewers: { user: user })
      end
    end
  end
end
