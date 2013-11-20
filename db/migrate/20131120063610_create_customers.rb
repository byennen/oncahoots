class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.belongs_to :club
      t.belongs_to :user
      t.string :stripe_id

      t.timestamps
    end
    add_index :customers, :club_id
    add_index :customers, :user_id
  end
end
