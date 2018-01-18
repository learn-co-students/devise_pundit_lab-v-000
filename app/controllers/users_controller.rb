class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user!, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.all
    authorize @users
  end
  
  def show
    authorize @user
    # redirect_to root_path, notice: "Access denied." unless @user == current_user || @user.admin?
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
    @user.update(user_params)
    authorize @user
  end
  
  def destroy
    @user.destroy
    authorize @user
  end
  
  def user_params
    params.require(:user).permit(:email, :password, :role)
  end
  
  def set_user!
    @user = User.find(params[:id])
  end
end