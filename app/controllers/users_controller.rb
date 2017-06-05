class UsersController < ApplicationController
    def index
        @users = User.all
        authorize current_user
    end

    def show
        @user = User.find_by(id: params[:id])
        authorize @user
    end

    def update
        @user = User.find(params[:id])
        authorize @user
        if @user.update(user_params)
            redirect_to @user
        else
            render '/edit'
        end
    end

    def destroy
        @user = User.find(params[:id])
        authorize @user
        @user.destroy
        redirect_to '/'
    end

    private
    def user_params
     params.require(:user).permit(:email, :password, :name)
    end
end
