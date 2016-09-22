class NotePolicy < ApplicationPolicy
  attr_reader :user, :note
  def initialize(user, note)
    @user = user
    @note = note
  end

  def create?
    binding.pry
    note.try(:user) == user
  end
  #
  # def index?
  #   user.admin?
  # end
  #
  # def show?
  #   the_user == user || user.admin?
  # end
  #
  # def update?
  #   user.admin?
  # end
  #
  # def destroy?
  #   user.admin?
  # end

end
