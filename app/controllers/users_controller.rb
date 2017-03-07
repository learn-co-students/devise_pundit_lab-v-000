class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user

  def index
    @user = current_user
  end

  def show
    # binding.pry
    if !current_user.admin? && current_user.id != params[:id].to_i
        flash[:alert] = "Access denied."
        redirect_to '/'
    end
  end

  def create
    User.find_or_create_by(user_params(:name))
  end

  def destroy
    return head(:forbidden) unless current_user.admin?
    @user.delete
    redirect_to 'www.google.com'
  end

  def update
    if current_user.admin? || current_user.id != params[:id].to_i
        @user.update(user_params)
        redirect_to root_path
    else
        flash[:alert] = "Access denied."
        redirect_to root_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def authorize_user
    authorize current_user
  end
    
  def user_params(*args)
    params.require(:user).permit(*args)
  end

end