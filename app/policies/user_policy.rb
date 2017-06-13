class UserPolicy < ApplicationPolicy

    def index?
        admin_only
    end
    
    def show?
        admin_only || record == user
    end
    
    def update?
        admin_only
    end

    def destroy?
        admin_only
    end

    private

    def admin_only
        user.admin?
    end
end
