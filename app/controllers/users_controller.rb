class UsersController < ApplicationController

  def edit
  end

  def create
  end

  def destroy
    @user = authorize User.find(current_user.id)
    @user.destroy
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def index
    @users = User.all
  end
end
