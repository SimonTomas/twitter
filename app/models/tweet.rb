class Tweet < ApplicationRecord
    belongs_to :user, class_name: "User", foreign_key: "user_id"
    validates :content, presence: true, length: { maximum: 140 }
    has_many :likes, dependent: :destroy
    has_many :linking_users, :through => :likes, :source => :user
    paginates_per 50
    has_many :tweets
    belongs_to :tweets, optional: true
    validates :tweet_id, uniqueness: { scope: :user_id }, allow_nil: true

    scope :tweets_for_me, ->(users_list) { where(
        user_id: users_list.map do |friend|
            friend.friend_id
        end
    ) }

    scope :created_between, ->(start_date, end_date) {where(
        "(created_at) >= ? AND (created_at) <= ?", start_date, end_date
    ) }

    def retweets
        retweet_count = Tweet.group(:tweet_id).count
        retweet_count.each do |key, value|
            if self.id == key
                return value
            end
        end
        return 0
    end
            
end
