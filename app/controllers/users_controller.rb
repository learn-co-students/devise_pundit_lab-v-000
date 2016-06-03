class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user != current_user
      flash[:alert] = "Access denied."
      redirect_to root_path
    end
    policy(@user).show?
  end

  def index
    @user = current_user
    @users = User.all
    policy(@users).index?
  end
end
