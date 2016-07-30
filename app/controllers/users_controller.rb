class UsersController < ApplicationController
  before_action :authenticate_user!, :except => [:index]

  def index
    @user = User.find_by(params[:id])
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

end
