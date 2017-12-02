class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    if !current_user.admin? && current_user != @user
      flash[:error] = "Access denied." 
      redirect_to root_path
    end

  end

  def update
    @user = User.find_by_id(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def destroy
  end

  def user_params
    params.require(:user).permit(:name,:email,:password)
  end


end