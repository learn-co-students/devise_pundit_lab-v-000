class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    @user.update(user_params)
    redirect_to root_path
  end

  def destroy
    
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :role)
  end

end