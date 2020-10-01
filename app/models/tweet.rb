class Tweet < ApplicationRecord
    belongs_to :user
    validates :content, presence: true
    has_many :likes, dependent: :destroy
    has_many :retweets, class_name: 'Tweet', foreign_key: 'retweet_id'

    paginates_per 5
end
