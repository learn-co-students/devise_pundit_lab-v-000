class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find_by id: params[:id]
    authorize @user
  end

  def destroy
    user = User.find_by id: params[:id]
    user.destroy
    redirect_to users_path, message: 'User deleted.'
  end
end
