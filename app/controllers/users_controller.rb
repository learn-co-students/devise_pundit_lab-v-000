class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      redirect_to '/'
    else
      render :new
    end
  end

  def update
    @user.update(user_params)
    redirect_to '/'
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    redirect_to :back, :alert => "Access denied." unless authorize @user
  end

  def index
    @users = User.all
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :role)
  end
end
