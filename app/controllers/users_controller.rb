class UsersController < ApplicationController
  def index
    @users = User.all
    if user_signed_in?
      @current_user = current_user
    end
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end
end
