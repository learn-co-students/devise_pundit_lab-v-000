class NotePolicy < ApplicationPolicy
  def index?
    user.admin? || user.moderator?
  end
end
