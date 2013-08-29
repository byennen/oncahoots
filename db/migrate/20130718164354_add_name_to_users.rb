class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :university_id, :integer
    add_column :users, :location_id, :integer
    add_column :users, :graduation_year, :string
    add_column :users, :major, :string
    add_column :users, :double_major, :string
    add_column :users, :slug, :string, unique: true
  end
end
