class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :alertable_id
      t.string :alertable_type
      t.string :message
      t.timestamps
    end
  end
end
