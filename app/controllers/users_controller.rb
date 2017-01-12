class UsersController < ApplicationController
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @user = current_user
    @users = User.all
    authorize @user
  end

  def show
    @user = User.find_by(id: params[:id])
    authorize @user
  end

  def edit
  end

  def update
  end

  def destroy
  end 

    private

    def user_not_authorized
      flash[:alert] = "Access denied."
      redirect_to(request.referrer || user_path)
    end

end
