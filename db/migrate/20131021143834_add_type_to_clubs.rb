class AddTypeToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :type, :string
  end
end
