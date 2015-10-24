require "rails_helper"
require "./lib/compadre/friendable"

RSpec.describe Compadre::Friendable do
  let(:user) { User.create! }
  let(:another_user) { User.create! }

  describe "#received_friend_requests" do
    before(:each) do
      Compadre::FriendRequest.create!(requested_id: user.id,
                                      requester_id: another_user.id)
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
      Compadre::FriendRequest.create!(requester_id: user.id,
                                      requested_id: another_user.id)
    end

    it "returns an ActiveRecord::Relation" do
      expect(user.sent_friend_requests).to be_a(ActiveRecord::Relation)
    end

    it "returns sent friend request objects" do
      friend_request = user.sent_friend_requests.first
      expect(friend_request.requester_id).to eq(user.id)
    end
  end

  describe "#send_friend_request_to" do
    it "creates a new friend request" do
      expect {
        user.send_friend_request_to(another_user)
      }.to change { Compadre::FriendRequest.all.count }.by(1)
    end

    it "has the correct requester_id" do
      friend_request = user.send_friend_request_to(another_user)
      expect(friend_request.requester_id).to eq(user.id)
    end

    it "has the correct requested_id" do
      friend_request = user.send_friend_request_to(another_user)
      expect(friend_request.requested_id).to eq(another_user.id)
    end
  end

  describe "#accept_friend_request_from" do
    before(:each) do
      another_user.send_friend_request_to(user)
      user.accept_friend_request_from(another_user)
    end

    it "creates the friendship for the requested" do
      expect(user.friends.map(&:id)).to include(another_user.id)
    end

    it "creates the friendship for the requester" do
      expect(another_user.friends.map(&:id)).to include(user.id)
    end

    it 'friends_with returns true' do
      expect(user.friends_with(another_user)).to be(true)
    end

    it "destroys the friend_request" do
      expect(Compadre::FriendRequest.all.count).to eq(0)
    end
  end
end
