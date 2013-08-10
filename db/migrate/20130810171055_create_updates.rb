class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.text :body
      t.belongs_to :updateable, polymorphic: true
      t.timestamps
    end
    add_index :updates, [:updateable_id, :updateable_type]
  end
end
