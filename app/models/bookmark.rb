class Bookmark < ApplicationRecord
  belongs_to :feed
  belongs_to :user
  validates :feed_id, uniqueness: true
end
