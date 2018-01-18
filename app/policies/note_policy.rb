class NotePolicy < ApplicationPolicy
  def create?
       user.admin? || record.try(:user) == user
  end

end
