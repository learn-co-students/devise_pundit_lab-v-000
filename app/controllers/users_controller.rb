class UsersController < ApplicationController

  def index
    @users = User.all
    authorize @users
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    if current_user == @user
      render :show
    else
      redirect_to root_path
      flash.alert = "Access denied."
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path
  end
end
