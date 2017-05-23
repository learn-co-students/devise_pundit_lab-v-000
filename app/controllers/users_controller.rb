class UsersController < ApplicationController

  def index
    @current_user = current_user
  end

  def show
    redirect_to :back, :alert => "Access denied." unless current_user.try(:id) == params[:id].to_i || current_user.admin?
  end

end