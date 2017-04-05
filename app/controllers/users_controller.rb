class UsersController < ApplicationController


  def index
    @user = current_user
    authorize @user
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    authorize @user
  end

  def destroy
    @user = User.find_by(id: params[:id])
    authorize @user
    @user.destroy
    redirect_to home_path
  end



end
