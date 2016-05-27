class UsersController < ApplicationController
  def index
    @user = current_user
    @users = User.all
    policy(@users).index?
  end

  def show
    @user = User.find(params[:id])
    if current_user != @user
      flash[:alert]= "Access denied."
      redirect_to root_path
    end
    policy(@user).show?


  end

end
