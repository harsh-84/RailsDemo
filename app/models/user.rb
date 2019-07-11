class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :feeds
  has_many :contacts
  has_one_attached :photo
  has_many :bookmarks, dependent: :destroy
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable,:omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  before_invitation_created :create_friendship
  after_invitation_accepted :accept_friendship

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

    def bookmark_for_feed(feed_id)
      bookmarks.find_by_feed_id(feed_id)
    end

    def friend_list
      (friendships.accept.map{|fr| fr.friend } + inverse_friendships.accept.map{|fr| fr.user}).uniq
    end

    def self.search(search,user_id)
      if search
        where("email LIKE ? and id <> ?" ,"%#{search}%", user_id)
        
      else
        all
      end
    end

    def self.all_except(user)
      where.not(id: user)
    end

  private
    def create_friendship
      self.inverse_friendships.build(user_id: invited_by.id)

    end

    def accept_friendship
      status = Friendship.statuses["accept"]
      self.inverse_friendships.first.update(status: status)
    end
end
