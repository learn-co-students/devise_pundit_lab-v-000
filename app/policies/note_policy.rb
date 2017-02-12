class NotePolicy < ApplicationPolicy
  def resolve
    if user.admin?
      scope.all
    end
  end
  def create?

  end

  def update?

  end

  def read?

  end
end
