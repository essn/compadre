module Compadre
  class Friendship < ActiveRecord::Base
    belongs_to :user, class_name: "#{Compadre.resource_name}"
    belongs_to :friend, class_name: "#{Compadre.resource_name}"

    validates :user_id, :friend_id, presence: true
  end
end
