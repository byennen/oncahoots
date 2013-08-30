class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :club_id
      t.boolean :admin
      t.boolean :manager

      t.timestamps
    end
  end
end
