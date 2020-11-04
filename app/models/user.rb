class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :portrait

  has_many :follow_users, class_name: 'FollowUser', foreign_key: 'following_user_id'
  has_many :followings, through: :follow_users, source: :followed_user
  has_many :reverse_of_follow_users, class_name: 'FollowUser', foreign_key: 'followed_user_id'
  has_many :followers, through: :reverse_of_follow_users, source: :following_user

  def self.find_for_github_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

end
