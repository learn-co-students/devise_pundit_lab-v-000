class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    authorize User
  end

  def show
    authorize @user
  end

  def update
    authorize @user 
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      redirect_to user_path(@user), alert: "Unable to update"
    end
  end

  def destroy
    authorize @user 
    @user.destroy
    redirect_to root_path, alert: "User deleted"
  end

  def about
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

end