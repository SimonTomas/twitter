module TweetsHelper
    def transform_to_hash(tweets)
        hash = tweets.map{|tweet| { "id" => tweet.id, "content" => tweet.content, "user_id" => tweet.user_id, "like_count" => tweet.likes.count, "retweets_count" => tweet.retweets, "retweeted_from" => tweet.tweet_id }}
        pretty_hash = JSON.pretty_generate(hash)
    end

    def transform_to_hash_with_date(tweets)
        hash = tweets.map{|tweet| { "id" => tweet.id, "content" => tweet.content, "user_id" => tweet.user_id, "like_count" => tweet.likes.count, "retweets_count" => tweet.retweets, "retweeted_from" => tweet.tweet_id, "created_at" => tweet.created_at }}
        pretty_hash = JSON.pretty_generate(hash)
    end
end