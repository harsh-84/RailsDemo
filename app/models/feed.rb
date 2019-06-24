class Feed < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  # ebum :status, ["gvh",dvhjb]
end
