class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # has_many :feed
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable,:omniauthable, omniauth_providers: [:facebook, :google_oauth2]

    def self.create_from_provider_data(provider_data)
      where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
        user.email = provider_data.info.email
        user.password = Devise.friendly_token[0, 20]
        # user.skip_confirmation!
      end
    end

    def self.create_from_google_data(provider_data)
      where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
        user.email = provider_data.info.email
        user.password = Devise.friendly_token[0, 20]
        # user.skip_confirmation!
      end
    end


 
end
