class Friendship < ApplicationRecord
  # include DeviseInvitable::Inviter
  belongs_to :user
  belongs_to :friend, :class_name => "User" 
  enum status: [:pending, :ignore, :accept ] 

end
