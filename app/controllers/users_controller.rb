class UsersController < ApplicationController

    before_action :set_user, only: [:show, :destroy]

    def index
        @user = current_user
    end

    def destory
        authorize @user
        @user.delete
    end

    def show
        raise "Access denied." unless policy(@user).show?
    end

    private
    def set_user
        @user = User.find(params[:id])
    end

end
