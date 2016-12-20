class UsersController < ApplicationController

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = authorize User.find(params[:id])
  end

  def destroy
    @user = authorize User.find(params[:id])
  end
end
