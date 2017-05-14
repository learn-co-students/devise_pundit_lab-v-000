class NotesController < ApplicationController
  
  def new
  end
  
  def create
  end

  def update   
  end
  
  def show
  end

  def index
    if current_user
      @notes = current_user.readable
    else 
      @notes = Note.none
    end
  end
end
