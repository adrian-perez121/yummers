class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  validates :first_name, :last_name, :email, presence: true

  has_one_attached :profile_photo
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy

  # Requesting {
  has_many :follow_requests, foreign_key: 'requested_id', class_name: 'Request', dependent: :destroy
  has_many :requesters, through: :follow_requests

  has_many :follow_requested, foreign_key: 'requester_id', class_name: 'Request', dependent: :destroy
  has_many :requests, through: :follow_requested, source: :requested # Yeah, this naming is a bit weird
  # }

  # Requesting {
  has_many :followings, foreign_key: 'followee_id', dependent: :destroy # Other users a user is following
  has_many :followers, through: :followings

  has_many :follows, class_name: 'Following', foreign_key: 'follower_id', dependent: :destroy
  has_many :followees, through: :follows
  # }
  after_commit :attach_default_profile_photo

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def liked?(likeable)
    Like.where(user: self, likeable: likeable).exists?
  end

  def disliked?(dislikeable)
    Dislike.where(user: self, dislikeable: dislikeable).exists?
  end

  def self.from_google(u)
    create_with(uid: u[:uid], first_name: u[:first_name], last_name: u[:last_name], provider: 'google',
                password: Devise.friendly_token[0, 20]).find_or_create_by!(email: u[:email])
  end

  private

  def attach_default_profile_photo
    profile_photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_profile.jpg')), filename: 'default_profile.jpg', content_type: 'image/jpg') unless profile_photo.attached?
  end
end
