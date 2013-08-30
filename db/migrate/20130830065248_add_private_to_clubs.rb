class AddPrivateToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :private, :boolean
  end
end
