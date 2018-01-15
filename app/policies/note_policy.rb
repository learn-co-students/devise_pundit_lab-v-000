class NotePolicy < ApplicationPolicy



  def index?
    !user.moderator?
  end
  def show?
    record == user || user.admin?
  end
  def update?
    record == user || user.admin?
  end

  def destroy?
    record == user || user.admin?
  end
end
