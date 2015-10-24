require 'rails_helper'

module Compadre
  RSpec.describe FriendRequest, type: :model do
    it { should validate_presence_of(:requester_id) }
    it { should validate_presence_of(:requested_id) }
  end
end
