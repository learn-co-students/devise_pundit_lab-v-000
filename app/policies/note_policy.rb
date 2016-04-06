class NotePolicy < ApplicationPolicy
    attr_reader :current_user, :new_note
    
    def initialize(current_user,new_note)
        @current_user = current_user 
        @new_note = new_note 
    end
    
    def show?
        @current_user.admin? || @current_user.vip? || @new_note.try(:user) == @current_user || @new_note.readers.include?(@current_user) 
    end
    
    def update?
       @current_user.admin? || @new_note.try(:user) == @current_user
    end

    def destroy?
       @current_user.admin? || @new_note.try(:user) == @current_user
    end
    
    def create?
      @current_user.admin? || @new_note.try(:user) == @current_user
    end
end