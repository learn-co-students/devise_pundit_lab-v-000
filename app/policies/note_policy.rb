class NotePolicy < ApplicationPolicy

  def create?
    user.admin? || user.owner_of?(record)
  end

  def update?
    user.admin? || user.owner_of?(record)
  end

  def index?
    user.persisted?
  end

  def show?
    user.admin? || user.moderator? || user.owner_of?(record)
  end

  def destroy?
    user.admin? || user.owner_of?(record)
  end

  class Scope < Scope
    def resolve
      return scope.none if user.nil?
      (user.admin? || user.moderator?) ? scope.all : scope.all.merge(user.readable)
    end
  end

end
