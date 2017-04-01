class UsersController < ApplicationController
  before_action :set_user!, except: [:index, :new, :create]

  def index
    binding.pry
    @users = User.all
  end

  def show
    #unless @user.id == current_user.id || current_user.admin?
    #  redirect_to root_path
    #  flash[:notice] = "Access denied."
    authorize @user
    end
  end

  private

  def set_user!
    @user = User.find(params[:id])
  end

end
