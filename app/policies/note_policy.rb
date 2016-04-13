class NotePolicy < ApplicationPolicy
  attr_reader :user, :note
  
  def initialize(user, note) 
    @user = user 
    @note = note
  end
  
  def show? 
    @user.admin? || @user.vip? || @user.notes.include?(@note) || @user.readable.include?(@note)
  end
  
  def edit? 
    @user.admin? || @user.notes.include?(@note)
  end
  
  def update?
    @user.admin? || @user.notes.include?(@note)
  end
  
  def destroy? 
    @user.admin? || @user.notes.include?(@note)
  end
end