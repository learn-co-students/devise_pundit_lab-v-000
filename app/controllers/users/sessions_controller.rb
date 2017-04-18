class Users::SessionsController < Devise::SessionsController
  before_filter :configure_sign_in_params, only: [:create]
  before_action :authenticate_user!

  # GET /resource/sign_in
  # def new
  #   super
  # end

  def index
    @user = current_user
    render 'users/index'
  end

  def show
    @user = current_user
    render 'users/show'
  end

  # POST /resource/sign_in
  def create
    if user_signed_in?
      flash[:notice] = "Signed in successfully."
      redirect_to '/'
    else
      flash[:alert] = "Invalid email or password."
      render :new, :locals => {resource: User.new(user_params)}
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def user_params
    params.require(:user).permit(configure_sign_in_params)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.for(:sign_in) << :attribute
  end
end
