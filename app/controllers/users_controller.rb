class UsersController < ApplicationController
  
  def index
    @users = User.all
  end

  def create
    @user = User.create(user_params)
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      unless @user == current_user || current_user.try(:admin?) 
        redirect_to root_path, notice: "Access denied."
      end
    else
      redirect_to root_path, notice: "Access denied."
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user.update(user_params)
    redirect_to '/'    
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email)
  end
end