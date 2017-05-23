class UsersController < ApplicationController

  def index
    # @current_user = current_user
  end

  def show
    redirect_to :back, :alert => "Access denied." unless current_user.try(:id) == params[:id].to_i || current_user.admin?
  end

  def edit
    raise current_user.inspect
    if current_user.admin?  
      raise current_user.inspect
      User.find(params[:id]).delete
    else
      raise current_user.inspect
      redirect_to root_path, :alert => "Access denied."
    end 
  end

end