class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = authorize User.find(params[:id])

  end
end
