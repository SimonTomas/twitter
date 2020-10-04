class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets, dependent: :destroy #Los tweets se eliminan si la cuenta es eliminada
  has_many :likes, dependent: :destroy #Los likes se eliminan si la cuenta es eliminada
  has_many :friends, dependent: :destroy

  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
  validates :profile_picture, format: { with: URL_REGEXP, message: 'You provided invalid URL' }, allow_blank: true

end
