class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    @users = User.all
    authorize User
  end

  def show
    authorize @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
