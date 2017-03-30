class UsersController < ApplicationController

  def new

  end

  def create
    @user = User.new(user_params)
    @user.save!
    redirect_to '/'
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
    redirect_to users_path, notice: "Access denied." if (@user != current_user)

  end

  def index
    @users = User.all
  end

  private

  def note_params
    params.require(:user).permit(:name, :email)
  end
end
