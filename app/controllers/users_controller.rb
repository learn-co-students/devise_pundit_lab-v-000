class UsersController < ApplicationController
  def new
  end

  def create
  end

  def index
    @users = User.all
  end

  def show
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :name)
  end
end
