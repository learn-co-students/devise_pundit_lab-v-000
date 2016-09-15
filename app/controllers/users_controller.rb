class UsersController < ApplicationController
  #@after_action :verify_authorized

  def index
    @users = User.all
    @user = current_user
    authorize @user
  end

  def show
    redirect_to visitors_home_path and return if current_user.nil?
    @user = current_user

    if params[:id]
      @other_user = User.find_by(id: params[:id])
      authorize @other_user if !@other_user.nil?
    end
  end
end
