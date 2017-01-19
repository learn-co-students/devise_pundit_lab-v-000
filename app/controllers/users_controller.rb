class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    
    authorize @user
  end

  def index
    @users = User.all
  end

  private

  def admin_rights
    unless current_user.admin? || @user == current_user
      redirect_to users_path, :alert => "Access Denied"
    end
  end

  def user_params
    params.require(:user).permit(:role)
  end

end
