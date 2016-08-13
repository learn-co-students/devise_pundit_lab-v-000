class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    flash[:alert] = "Access denied." if current_user.id != @user.id
  end

  def index
    @users = User.all
  end
end