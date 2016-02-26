class UsersController < ApplicationController
  def index
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    unless policy(@user).show?
      #binding.pry
      flash[:alert] = "Access denied."
    end
  end
end
