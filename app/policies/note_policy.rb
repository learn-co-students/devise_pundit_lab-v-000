class NotePolicy < ApplicationPolicy

  def create?
    user_or_admin
  end

  def edit?
    user_or_admin
  end

  def destroy?
    user_or_admin
  end

  def index?
    user_or_admin || user.moderator?
  end

  def update?
    user_or_admin
  end

  def show?
    user_or_admin || user.moderator?
  end

  private

    def user_or_admin
      user == record || user.admin?
    end

end
