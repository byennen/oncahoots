class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :university, :string
    add_column :users, :graduation_year, :string
    add_column :users, :major, :string
    add_column :users, :double_major, :string
  end
end
