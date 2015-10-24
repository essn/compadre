class CreateCompadreFriendships < ActiveRecord::Migration
  def change
    create_table :compadre_friendships do |t|
      t.integer :user_id
      t.integer :friend_id

      t.timestamps null: false
    end
    add_index :compadre_friendships, :user_id
    add_index :compadre_friendships, :friend_id
  end
end
