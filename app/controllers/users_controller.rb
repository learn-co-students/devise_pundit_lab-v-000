class UsersController < ApplicationController


  def create
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end


end
