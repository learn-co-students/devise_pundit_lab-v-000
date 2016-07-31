class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    redirect_to users_path, alert: "Access denied." unless
    authorize @user
  end
end
