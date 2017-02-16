class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    render plain: "Access denied." unless @user == current_user
  end

end
