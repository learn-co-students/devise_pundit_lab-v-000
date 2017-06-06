class UsersController < ApplicationController
  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find_by(id: params[:id])
    authorize @user
    @user.update(user_params)
  end

  def destroy
    @user = User.find_by(id: params[:id])
    authorize @user
    @user.destroy
  end



private

def user_params
  params.required(:user).permit(:name, :email, :password, :password_confirmation)
end

  end