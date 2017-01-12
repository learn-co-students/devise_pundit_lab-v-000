class UsersController < ApplicationController
  before_action :set_user

  def index
    @users = User.all
  end

  def show
    # authorize pundit_user
    redirect_to users_path, alert: "Access denied." unless current_user == @user
  end

  def destroy

  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

end
