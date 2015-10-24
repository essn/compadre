module Compadre
  module Friendable
    extend ActiveSupport::Concern

    included do
      has_many :friendships, class_name: "Compadre::Friendship",
                             foreign_key: :user_id
      has_many :friends, through: :friendships
    end

    def received_friend_requests
      Compadre::FriendRequest.where(requested_id: id)
    end

    def sent_friend_requests
      Compadre::FriendRequest.where(requester_id: id)
    end

    def send_friend_request_to(resource)
      Compadre::FriendRequest.create(requester_id: id,
                                     requested_id: resource.id)
    end

    def accept_friend_request_from(resource)
      friend_request = friend_request_from(resource)

      if friend_request
        requested_friendship = friendships.create(friend: resource)
        requester_friendship = resource.friendships.create(friend: self)
      end

      if requester_friendship.persisted? && requested_friendship.persisted?
        friend_request.destroy
        return true
      else
        return false
      end
    end

    def decline_friend_request_from(resource)
      friend_request = friend_request_from(resource)
      friend_request.destroy
    end

    def friend_request_from(resource)
      Compadre::FriendRequest.
        find_by_requested_id_and_requester_id(id, resource.id)
    end
  end
end
