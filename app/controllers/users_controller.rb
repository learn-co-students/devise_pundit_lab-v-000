class UsersController < ApplicationController

  def index
    @users = policy_scope(User)
  end

  def show
    @user = User.find(params[:id])
    authorize @user
    unless authorize @user
    flash.now[:alert] = "Access denied." 
    end
  end

  def update
    @user = authorize User.find(params[:id])
  end

  def destroy
    @user = authorize User.find(params[:id])
  end
end
