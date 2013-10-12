class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :name
      t.belongs_to :eventable, polymorphic: true

      t.timestamps
    end
    add_index :events, [:eventable_id, :eventable_type]
  end
end
