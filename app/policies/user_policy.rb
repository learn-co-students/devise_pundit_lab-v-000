class UserPolicy < ApplicationPolicy
  class Scope < Scope

    def index?
      user.admin?
    end

    def show?
      record == user
    end

    def update?
      user.admin? || user.moderator? || record.try(:user) == user
    end
  end
end
