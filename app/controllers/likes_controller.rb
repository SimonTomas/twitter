class LikesController < ApplicationController
    before_action :find_tweet
    before_action :find_like, only: [:destroy]

    def create
        if user_signed_in?
            @tweet.likes.create(user_id: current_user.id)
            redirect_to root_path
        else
            redirect_to root_path, alert: 'Para dar Like, debes iniciar sesión.'
        end
    end

    def destroy
        if already_liked?
            @like.destroy
            redirect_to root_path
        end
    end

    private

    def find_tweet
        @tweet = Tweet.find(params[:tweet_id])
    end

    def find_like
        @like = @tweet.likes.find(params[:id])
    end

    def already_liked?
        Like.where(
            user_id: current_user.id,
            tweet_id: params[:tweet_id]
        ).exists?
    end

end
