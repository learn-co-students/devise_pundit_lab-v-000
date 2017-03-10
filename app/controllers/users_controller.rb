class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    authorize User
    @users = User.all
  end

  # Show action is used for all types of users. Normal user can see own profile.
  # => it has different route: '/user/:id'
  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  private

    def set_user
      @user = User.find_by(id: params[:id])
    end
end
