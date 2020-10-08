class UsersController < ApplicationController
    def index
        @users = User.all
    end
    def show
        if user_signed_in?
        @user = User.find(params[:id])
        end
    end
end