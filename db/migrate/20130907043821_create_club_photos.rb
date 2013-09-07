class CreateClubPhotos < ActiveRecord::Migration
  def change
    create_table :club_photos do |t|
      t.integer :club_id
      t.string :image
      t.timestamps
    end
  end
end
