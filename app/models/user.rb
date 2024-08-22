class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  validates :first_name, :last_name, :email, presence: true

  has_one_attached :profile_photo

  # FIX TOMORROW
  def self.from_google(u)
    create_with(uid: u[:uid], first_name: u[:name], last_name: u[:name], provider: 'google',
                password: Devise.friendly_token[0, 20]).find_or_create_by!(email: u[:email])
  end
end
