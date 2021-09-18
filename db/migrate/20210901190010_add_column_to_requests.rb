class AddColumnToRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :requests, :reciever_id, :bigint
  end
end
