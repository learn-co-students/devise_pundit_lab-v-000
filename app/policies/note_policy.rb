class NotePolicy 
    attr_reader :user, :note
    
    def initialize(user,note)
        @user = user
        @note = note        
    end
    
    def show?
       @user.admin? || @user.moderator? || @user == @note.user
    end
    
    def index?
        @user.admin? || @user.moderator? || @user.user? || @user == @note.user
    end
    def new?
        @user.admin? || @user.moderator? || @user.user? || @user == @note.user
    end
    def edit?
        @user.admin? || @user == @note.user
    end
    def update?
        @user.admin? || @user.moderator? || @user == @note.user
    end
    def destroy?
        @user.admin? || @user == @note.user
    end
end