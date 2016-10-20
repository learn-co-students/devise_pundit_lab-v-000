class UsersController < ApplicationController

  def Home
    @users = User.all
  end

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    if authorize @user
      redirect_to users_path(@user)
    else
      redirect_to users_path, :alert => "Access denied."
    end
  end

  def update
    @user = User.find(params[:id])
    authorize @user
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
    @user.destroy
  end
end
