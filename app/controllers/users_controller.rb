require 'pry'
class UsersController < ApplicationController

def index
  @user = current_user
end

def show
  if current_user.id == params[:id].to_i || current_user.admin?
    @user = current_user
  else
    flash[:error] = "Access denied."
    redirect_to user_path(current_user)
  end
end

end
