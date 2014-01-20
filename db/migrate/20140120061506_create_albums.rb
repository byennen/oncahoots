class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.belongs_to :club
      t.belongs_to :user
      t.string :name
      t.string :location
      t.text :description

      t.timestamps
    end

    add_column :club_photos, :album_id, :integer
    add_column :club_photos, :featured, :boolean
    add_column :club_photos, :caption, :string
  end
end
