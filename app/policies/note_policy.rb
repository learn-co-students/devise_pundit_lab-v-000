class NotePolicy < ApplicationPolicy
    def index?
        moderator_can || admin_can
    end
    
    def show?
        moderator_can || admin_can || user_owned
    end

    def update?
        admin_can || user_owned
    end
    
    def destroy?
        admin_can || user_owned
    end

    private

    def admin_can
        user.admin?
    end

    def moderator_can
        user.moderator?
    end

    def user_owned
        record == user
    end
end