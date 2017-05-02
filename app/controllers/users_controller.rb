class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if @user != current_user && !current_user.admin?
      flash[:error] = "Access denied."
      redirect_to root_path
    end
  end
end
