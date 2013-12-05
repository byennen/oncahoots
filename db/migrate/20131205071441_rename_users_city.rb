class RenameUsersCity < ActiveRecord::Migration
  def up
    rename_column :users, :city, :other_city
  end

  def down
  end
end
