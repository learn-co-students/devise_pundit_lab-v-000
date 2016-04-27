class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    authorize_user
  end

  def authorize_user
    @user = User.find(params[:id])
    authorize @user
  end
end
