class UsersController < ApplicationController

  def update
    @user = User.find(params[:id])
    authorize @user
# perform an update
  end


end
