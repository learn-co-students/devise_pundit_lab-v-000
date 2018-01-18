class UsersController < ApplicationController
   

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    redirect_to root_path
  end

  def edit
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(user_params)
      redirect_to root_path, :notice => 'User updated.'
    else
      redirect_to root_path, :alert => 'Unable to update user.'
    end
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
    @user.destroy
    redirect_to root_path, :notice => 'User deleted.'
  end

  private

  def user_params
    params.require(:user).permit(:role, :name, :email, :password, :password_confirmation)
  end

end
