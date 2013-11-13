class CreateInteresteds < ActiveRecord::Migration
  def change
    create_table :interesteds do |t|
      t.belongs_to :user
      t.integer :interested_obj_id
      t.string :interested_obj_type

      t.timestamps
    end
    add_index :interesteds, :user_id
  end
end
