class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
