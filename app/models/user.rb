class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, omniauth_providers: [:facebook, :vkontakte]
  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :attachments, dependent: :destroy
  validates :email, presence: true
  validates :email, uniqueness: true

  def name
    email.split('@')[0]
  end

  def self.find_for_facebook_oauth access_token
    if user = User.where(url: access_token.info.email).first
      user.avatar_url = access_token.info.image
      user.save!
      user
    else
      user = User.new(provider: access_token.provider, avatar_url: access_token.info.image, url: access_token.extra.raw_info.link, email: access_token.extra.raw_info.email, password: Devise.friendly_token[0,20])
      user.skip_confirmation!
      user.save!
      user
    end
  end
 def self.find_for_vkontakte_oauth access_token
    if user = User.where(url: access_token.info.urls.Vkontakte).first
      user.avatar_url = access_token.info.image
      user.save!
      user
    else
      user = User.new(provider: access_token.provider, avatar_url: access_token.info.image, url: access_token.info.urls.Vkontakte, email: access_token.extra.raw_info.screen_name+'@vk.com', password: Devise.friendly_token[0,20])
      user.skip_confirmation!
      user.save!
      user
    end
  end
end
