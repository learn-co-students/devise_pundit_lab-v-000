class UsersController < ApplicationController

  def index
    @user = current_user
 	  @users = User.all
 	  authorize @user
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def create
  end

  def edit
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end
end
