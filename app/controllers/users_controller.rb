class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user || @user.admin?
      redirect_to root_path, :notice => "Access denied."
    end
  end

  def destroy
  end
end
