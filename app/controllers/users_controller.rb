class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @email = current_user.email
  end

  def show
    @user = User.find(params[:id])
    authorize @user
    @email = current_user.email
  end

  
end
