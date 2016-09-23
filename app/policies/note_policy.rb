class NotePolicy < ApplicationPolicy
  attr_reader :user, :note
  def initialize(user, note)
    @user = user
    @note = note
  end

  def create?
#    binding.pry
    note.try(:user) == user || user.admin?
  end

  def edit?
    note.try(:user) == user || user.admin?
  end

  def show?
    note.try(:user) == user || user.moderator? || user.admin?
  end

  def delete?
    note.try(:user) == user || user.admin?
  end

end
