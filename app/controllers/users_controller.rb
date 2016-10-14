class UsersController < ApplicationController

  def index
    @users = User.all
    binding.pry
  end

end
