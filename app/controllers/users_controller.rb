class UsersController < ApplicationController
  def index

    @users = User.all

  end

  def show
    #binding.pry
    @user = User.find(params[:id])
    # vs. @user = current_user (not in params, trying the auth what user, user can see.)
    authorize @user
  end

  def update
    #binding.pry
    @user = User.find(params[:id])
  end

  def destroy

  end
end
