class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    authorize @user
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(user_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end

end
