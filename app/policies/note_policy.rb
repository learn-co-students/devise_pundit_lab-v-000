class NotePolicy < ApplicationPolicy
  # class Scope < Scope

  #   def initialize(user, scope)
  #     @user = user
  #     @scope = scope
  #   end

  #   def resolve
  #     if @user.admin? || @user.moderator?
  #       scope.all 
  #     else
  #       scope.where
  #   end

  # end

  def initialize(user, note)
    @user = user
    @note = note
  end

  def index?
    @user.admin? || @user.moderator? || @user
  end

  # def show?
   
  # end

  def update?
    @user.admin? || @note.user == @user
  end

  def destroy?
    @user.admin?
  end

end