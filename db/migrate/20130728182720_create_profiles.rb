class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.text :skills
      t.string :education
      t.text :experience

      t.timestamps
    end
  end
end
