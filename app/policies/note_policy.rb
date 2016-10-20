class NotePolicy < ApplicationPolicy
attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def create
    user.admin? || record.try(:user_id) == user.id
  end

  def update
  end

  def destroy
  end

  def show
  end
end
