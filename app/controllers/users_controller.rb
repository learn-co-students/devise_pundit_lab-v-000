class UsersController < ApplicationController
  before_action :set_user, only: [:show, :create, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    authorize @user
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
