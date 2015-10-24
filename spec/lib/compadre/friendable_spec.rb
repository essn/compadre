require "rails_helper"
require "./lib/compadre/friendable"

RSpec.describe Compadre::Friendable do
  let(:user) { double("user", id: 1) }

  before(:each) do
    user.extend(Compadre::Friendable)
  end

  describe "#received_friend_requests" do
    before(:each) do
      Compadre::FriendRequest.create!(requested_id: 1, requester_id: 2)
    end

    it "returns an ActiveRecord::Relation" do
      expect(user.received_friend_requests).to be_a(ActiveRecord::Relation)
    end

    it "returns requested friend request objects" do
      friend_request = user.received_friend_requests.first
      expect(friend_request.requested_id).to eq(user.id)
    end
  end

  describe "#sent_friend_requests" do
    before(:each) do
      Compadre::FriendRequest.create!(requester_id: 1, requested_id: 2)
    end

    it "returns an ActiveRecord::Relation" do
      expect(user.sent_friend_requests).to be_a(ActiveRecord::Relation)
    end

    it "returns sent friend request objects" do
      friend_request = user.sent_friend_requests.first
      expect(friend_request.requester_id).to eq(user.id)
    end
  end
end
