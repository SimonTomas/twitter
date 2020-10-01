class Tweet < ApplicationRecord
    belongs_to :user
    validates :content, presence: true, unless: :retweet_id?
    has_many :likes, dependent: :destroy
    has_many :linking_users, :through => :likes, :source => :user
    has_many :retweets, foreign_key: 'retweet_id'

    paginates_per 50
end
