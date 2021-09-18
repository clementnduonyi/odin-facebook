class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.bigint :sender_id
      t.bigint :friend_id

      t.timestamps
    end
  end
end
