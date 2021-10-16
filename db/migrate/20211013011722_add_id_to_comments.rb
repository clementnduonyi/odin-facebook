class AddIdToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :parent_id, :bigint
  end
end
