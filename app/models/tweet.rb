class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :retweets, class_name: 'Tweet', foreign_key: 'retweet_id'
end
