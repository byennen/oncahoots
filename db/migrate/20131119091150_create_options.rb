class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.belongs_to :item
      t.string :name
      t.string :value

      t.timestamps
    end
    add_index :options, :item_id
  end
end
