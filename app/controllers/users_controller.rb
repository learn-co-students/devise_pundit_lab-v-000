class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:create, :new]
  before_action :set_user!, except: [:create, :index, :new]
  before_action :admin_only, only: :destroy

  def new
  end

  def create
  end

  def index
    @users = User.all
    authorize @users
  end

  def show
    puts params.inspect
    @user = User.find(params[:id])
    authorize @user
  end

  def update
  end

  def destroy

  end

private
  def secure_params
    params.require(:user).permit(:role)
  end


end
