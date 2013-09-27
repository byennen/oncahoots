class AddAlumniBooleanToUsers < ActiveRecord::Migration
  def change
    add_column :users, :alumni, :boolean
  end
end
