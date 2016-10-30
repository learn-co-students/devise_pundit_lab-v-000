class UsersController < ApplicationController
  def destroy
    @user = User.find_by(id: params[:id])
    authorize(@user)
    @user.destroy
    redirect_to '/'
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    authorize(@user)
  end
end