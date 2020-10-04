class FriendsController < ApplicationController
    before_action :find_user
    before_action :find_friend, only: [:destroy]

    def create
        current_user.friends.create(
            friend_id: @user.id
        )
        redirect_to root_path
    end

    def destroy
        if already_follow?
            @friendship.destroy
            redirect_to root_path
        end
    end

    private
    def find_user
        @user = User.find(params[:user_id])
    end

    def find_friend
        @friends = current_user.friends
        @friendship = @friends.find_by(id: @friends)
    end

    def already_follow?
        @user = User.find(params[:user_id])
        Friend.where(
            user_id: current_user.id,
            friend_id: @user.id
        ).exists?
    end
end