module Compadre
  class FriendRequest < ActiveRecord::Base
    validates :requester_id, :requested_id, presence: true
  end
end
