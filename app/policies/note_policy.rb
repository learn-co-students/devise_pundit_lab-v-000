class NotePolicy < ApplicationPolicy

  class Scope < UserPolicy

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

     def resolve
       if @user.admin?
         @scope.all
       else
         @scope.where(:id => @user.id)
       end
     end
    end


  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user.admin? || @record.try(:user) == @user
  end

  def create?
    @user != nil
  end

  def show?
    @user.admin? || @user.moderator? || @record.readers.include?(@user)
  end

  def update?
    @user.admin? || @record.try(:user) == @user
  end

  def destroy?
    @user.admin? || @record.try(:user) == @user
  end


end
