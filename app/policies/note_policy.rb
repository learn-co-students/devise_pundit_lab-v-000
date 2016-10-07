class NotePolicy < ApplicationPolicy
  attr_reader :user, :note

  def initialize(user, note)
    @user = user
    @note = note
  end

  def update?
    user.admin? or not note.published?
  end


end