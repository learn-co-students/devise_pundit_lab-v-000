class UsersController < ApplicationController
  # Device Authentication
  before_action :authenticate_user!, except: [:index]
  # Set Parameters exept for Index
  before_action :set_user, except: [:index]

  def index
    @user = current_user
    authorize @user #=> Pundit UserPolicy
  end

  def show
    authorize @user #=> Pundit UserPolicy
  end

  def edit

  end

  def update
    @user.update(user_params)
    authorize @user #=> Pundit UserPolicy
  end

  def destroy
    @user.destroy
    authorize @user #=> Pundit UserPolicy
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  # STRONG PARAMETERS
  def user_params
    params.require(:user).permit(:email, :password, :role)
  end
end
