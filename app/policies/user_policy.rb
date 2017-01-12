class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def destroy?
    user.admin? && record != user
  end

  def update?
    user.admin?
  end

  def show?
    user.admin? || record == user
    #usually we are used to asking "record.user" (i.e., post.user > who is a post's user?)
    #but here we are trying to limit a user's show page
      #instead we ask is the @user (the pundit record) the current_user (the pundit user)
  end

end
