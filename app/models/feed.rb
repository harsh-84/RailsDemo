class Feed < ApplicationRecord
  belongs_to :user
  has_many :bookmark, dependent: :destroy
  has_one_attached :image

  enum privacy: {show_all: 'public', only_me: 'only_me', friend: 'friend'}


  scope :user_feeds, ->(user_id,friend_list) { where("user_id = ? or privacy = ? or  (privacy = ? and user_id IN  (?)) ",user_id,privacies[:show_all],privacies[:friend],friend_list) }



  
end
