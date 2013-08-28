class AddImageToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :image, :string
  end
end
