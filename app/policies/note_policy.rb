class NotePolicy < ApplicationPolicy

  def new?
    user_logged_in?
  end

  def update?
    user.admin? || user.moderator? || record.try(:user) == user
  end
end