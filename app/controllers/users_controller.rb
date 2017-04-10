class UsersController < ApplicationController
  before_action :ensure_user_owner, only: [:show]

  def index
    @users = User.all
  end

  def show
  end

  private

  def ensure_user_owner
    @user = User.find(params[:id])
    unless @user == current_user || current_user.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end
end
