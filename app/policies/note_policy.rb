class NotePolicy < ApplicationPolicy 
  def update?
    user.admin? || user.vip? || record.try?(:user) == user
  end

end