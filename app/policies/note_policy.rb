class NotePolicy < ApplicationPolicy
  attr_reader :note

  def initialize(user, note)
    super(user, note)
    @note = record
  end

  def update
    user.admin? or not record.published?
  end

end