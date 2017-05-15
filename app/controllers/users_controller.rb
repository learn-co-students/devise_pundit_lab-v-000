class UsersController < ApplicationController
  before_action :authenticate_user!
  def index

  end

  def show
    if current_user.id.to_s != params[:id]
      flash[:alert] = "Access denied."
      redirect_to root_path
    end
  end

end
