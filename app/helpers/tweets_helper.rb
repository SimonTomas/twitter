module TweetsHelper
    def count_retweets(tweet)

    end
    def hashtag(tweet)
        tweet.scan(/#\w+/).map{|name| name.gsub("#", "")}
    end
end