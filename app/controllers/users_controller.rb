class UsersController < ApplicationController
  

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
     if !current_user.admin? || current_user != @user
      flash[:error] = "Access denied."
      end
  end

  def destroy
     @user = User.find(params[:id])
     authorize @user
  end


end
