class Tweet < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    validates :content, presence: true, length: { maximum: 140 }
    has_many :likes, dependent: :destroy
    has_many :linking_users, :through => :likes, :source => :user
    # validates :retweet_id, uniqueness: { scope: :user_id }
    has_many :retweets, foreign_key: 'retweet_id'
    paginates_per 50
end
