class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
  end

  def create
  end

  def show
    @user = User.find(params[:id])
    authorize @user
    if !authorize @user
      flash[:alert] = "Access denied."
      redirect_to users_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def about
  end

end
