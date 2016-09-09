class UsersController < ApplicationController

  def index
    @users = User.all
    @user ||= current_user
  end

  def show
    @user = User.find(params[:id])
    binding.pry
    authorize @user
  end
end
