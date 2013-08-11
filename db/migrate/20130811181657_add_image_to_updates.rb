class AddImageToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :image, :string
  end
end
