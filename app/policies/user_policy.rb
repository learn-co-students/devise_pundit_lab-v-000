class UserPolicy < ApplicationPolicy

    def index?
      user.admin?
    end

    def show
      user.admin? || record == user
    end

    def update?
       user.admin? || record.try(:user) == user
    end

    def destroy?
      user.admin?
    end
end
