class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :firstname, :string
    add_column :users, :surename, :string
    add_column :users, :birth_date, :date
    add_column :users, :male, :string
    add_column :users, :female, :string
  end
end
