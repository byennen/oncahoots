class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :category
      t.text :description
      t.integer :university_id
      t.integer :user_id
      t.string :slug

      t.timestamps
    end
  end
end
