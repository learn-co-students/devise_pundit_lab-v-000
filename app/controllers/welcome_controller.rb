class WelcomeController < ApplicationController

  def index
    @user = current_user if current_user
  end
end
