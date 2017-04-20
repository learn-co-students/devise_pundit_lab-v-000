class UsersController < ApplicationController

  # def new
  # end
  #
  # def create
  # end

  def index
    @users = User.all
    authorize @users
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
  end

end
