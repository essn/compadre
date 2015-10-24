require "rails_helper"

module Compadre
  RSpec.describe Friendship, type: :model do
    # Associations
    it { should belong_to(:user) }
    it { should belong_to(:friend) }

    # Validations
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:friend_id) }
  end
end
