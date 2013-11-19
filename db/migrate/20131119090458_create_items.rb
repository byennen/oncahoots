class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.belongs_to :club
      t.string :name
      t.text :description
      t.string :status
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end
    add_index :items, :club_id
  end
end
