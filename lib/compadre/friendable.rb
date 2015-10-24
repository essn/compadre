module Compadre
  module Friendable
    def received_friend_requests
      Compadre::FriendRequest.where(requested_id: id)
    end

    def sent_friend_requests
      Compadre::FriendRequest.where(requester_id: id)
    end
  end
end
