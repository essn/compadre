class CreateCompadreFriendRequests < ActiveRecord::Migration
  def change
    create_table :compadre_friend_requests do |t|
      t.integer :requester_id
      t.integer :requested_id

      t.timestamps null: false
    end
    add_index :compadre_friend_requests, :requester_id
    add_index :compadre_friend_requests, :requested_id
  end
end
