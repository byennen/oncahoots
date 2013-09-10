class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :club_id
      t.integer :user_id
      t.string :status
      t.timestamps
    end
  end
end
