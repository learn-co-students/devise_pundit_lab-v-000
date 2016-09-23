class ViewerPolicy < ApplicationPolicy
  attr_reader :user, :viewer
  def initialize(user, viewer)
    @user = user
    @viewer = viewer
  end

  def create?
#    binding.pry
    viewer.try(:user) == user
  end

  def show?
    viewer.try(:user) == user
  end

  def delete?
    viewer.try(:user) == user
  end

end
