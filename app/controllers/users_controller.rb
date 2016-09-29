class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if !current_user.admin? && current_user != @user
      flash[:error] = "Access denied."
      redirect_to root_path
    end
  end

  def index
    @users = User.all
    authorize current_user
  end

  def update
    @user = User.find_by(id: params[:id])
    authorize current_user
    @user.update(user_params)
  end

  def destroy
    @user = User.find(params[:id])
    authorize current_user @user
    if current_user.admin? || current_user == @user
      @user.destroy
    else
      flash[:error] = "Access denied."
    end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

end
