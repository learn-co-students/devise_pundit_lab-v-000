class UserPolicy < ApplicationPolicy

    def index?
      admin_status
    end

    def show?
      user == record || user.admin?
    end

    def update?
      admin_status
    end

    def destroy?
      admin_status && user != record
    end

    private

      def admin_status
        user.admin?
      end

end
