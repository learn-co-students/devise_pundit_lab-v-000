class UserPolicy < ApplicationPolicy

  def index?
    @user.admin?
  end

  def show?
    #raise record.inspect
    @user.admin? || record.id == user.id
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
    #false if @user == record
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
