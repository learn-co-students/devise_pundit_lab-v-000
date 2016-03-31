class UsersController < ApplicationController


  def index
    @users = User.all
    authorize User
  end

  def new
  new

  def create

  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    authorize @user
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
  end
end
end