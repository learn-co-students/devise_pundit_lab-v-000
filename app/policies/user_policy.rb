class UserPolicy < ApplicationPolicy

  def index?
    @user.admin?
  end


  class Scope < Scope


    def resolve
      if @user.admin?
        scope.all
      else
        scope.where(id: user.id).exists?
      end
    end
  end
end
