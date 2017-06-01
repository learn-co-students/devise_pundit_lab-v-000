class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # if @user.save
    #   redirect_to @user
    # else
    #   redirect_to new_user_registration_path
    # end
  end


  def index
    @users = User.all
    authorize @users
  end

  def show
    # if current_user != @user
    #   redirect_to root_path, alert: "Access denied."
    # end
    authorize @user
  end

  def edit
    # if current_user != @user
    #   redirect_to root_path, alert: "Access denied."
    # end
  end

  def update
    authorize @user
    @user.update(user_params)
  end

  def destroy
    authorize @user
    @user.destroy
  end

  private

    def user_params
      params.required(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def set_user
      @user = User.find_by(id: params[:id])
    end
end
