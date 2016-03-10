class NotePolicy < ApplicationPolicy
  
  def initialize(current_user, note)
    @current_user = current_user
    @note = note
  end

  def show?
    @current_user.admin? || @current_user.vip? || @current_user.id == @note.user_id
  end

  def create?
    @current_user
  end

  def edit?
    @current_user.id == @note.user_id || @current_user.admin?
  end

  def destroy?
    # binding.pry
    @current_user.id == @note.user_id || @current_user.admin?
  end


  # def index?
  #   @current_user.admin?
  # end

  # def show?
  #   @current_user.admin? || @current_user == @user
  # end

  # def update?
  #   @current_user.admin?
  # end

  # def destroy?
  #   @current_user.admin?
  # end


end
