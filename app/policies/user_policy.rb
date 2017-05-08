class UserPolicy < ApplicationPolicy

  attr_reader :user, :note

  def initialize(user, note)
    @user = user
    @note = note
  end

  def show?
    user.admin? || user.id == note.id
  end

  def index?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end

end
