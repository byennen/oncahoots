class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :club_id
      t.string :file
      t.timestamps
    end
  end
end
