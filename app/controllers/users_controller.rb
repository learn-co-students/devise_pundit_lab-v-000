class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :detroy]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @users = User.all
  end

  def show
    authorize @user
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_not_authorized
      flash[:alert] = "Access denied."
      redirect_to root_path
    end
end
