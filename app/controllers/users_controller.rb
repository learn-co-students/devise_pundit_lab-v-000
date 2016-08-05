class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end


end