class AddIndexToFriends < ActiveRecord::Migration[6.1]
  def change
    add_index :friends, :user_id
    add_index :friends, :friend_id
  end
end
