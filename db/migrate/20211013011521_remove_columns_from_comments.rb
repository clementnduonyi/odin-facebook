class RemoveColumnsFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :parent_id
  end
end
