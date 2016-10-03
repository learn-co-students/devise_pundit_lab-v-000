class UsersController < ApplicationController
  #this method that is reponsible for raising an exception if authorize is not called
  # after_action :verify_authorized#, except: :index
  before_action :set_user!, only: [:show, :destroy]

  def index
    # authorize user
    @users = User.all
  end

  # def new
  # end
  #
  # def create
  # end

  def show
    # binding.pry
    @user
    authorize @user
  end

  # def edit
  # end
  #
  # def update
  #   authorize user
  #   binding.pry
  # end

  # def destroy
  # end

  private

    def set_user!
      @user = User.find_by(id: params[:id])
    end
    # def user_params
    #   params.require(:user).permit(:name, :email)
    # end

end
