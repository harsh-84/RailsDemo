module FriendshipsHelper
  def status_checker(user,current_user)
    friendship = Friendship.where("(user_id = :user_id AND friend_id = :friend_id) || (user_id = :friend_id AND friend_id = :user_id)", user_id: user.id, friend_id: current_user).first

    if friendship
      case friendship.status
      when 'pending'
        link_to "Cancel Requeest",friendship_path(user.id),  :method => :delete
      when 'accept'
        link_to "Unfriend",friendship_path(user.id),  :method => :delete
      end
    else
      link_to "Add friend", friendships_path(:friend_id =>  user), :method => :post 
    end
  end
  
 
end
