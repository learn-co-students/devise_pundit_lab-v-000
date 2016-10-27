class UsersController < ApplicationController

  def index
    @users = User.all 
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end 

  def update
    authorize @user 
  end

  def destroy
    authorize @user 
    @user.destroy 
    redirect_to users_url, notice: 'User successfully destroyed.'
  end 

end
