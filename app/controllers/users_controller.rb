class UsersController < ApplicationController

  def index
    @users = User.all
    if user_signed_in? ## Learn expert instructed me to add a check here
      # to set @current_user because for some reason current_user was broken in views
      @current_user = current_user
    end
  end

  def show
    @user = User.find(params[:id])
  end

end
