require 'pry'
class NotePolicy 
  attr_reader :user, :note
    
  def initialize(user,note)
    @user = user
    @note = note        
  end

  def new?
    @user.admin? || @user.moderator? || @user == @note.user
  end

  def update? 
    @user.admin? || @user == @note.user
  end 

  def delete? 
    @user.admin? || @user == @note.user 
  end 

  def add_reader? 
    @user.admin? || @user == @note.user
  end 

  def remove_reader? 
    @user.admin? || @user == @note.user 
  end 

  def show? 
    @user.admin? || @user == @note.user || @user.moderator? || @user.viewer?(@user, note)
  end 
  

  
end 
  