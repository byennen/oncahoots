class CreateClubEvents < ActiveRecord::Migration
  def change
    create_table :club_events do |t|
      t.integer :club_id
      t.string :title
      t.string :time
      t.string :date
      t.string :location
      t.string :description
      t.string :category
      t.string :image
      t.timestamps
    end
  end
end
