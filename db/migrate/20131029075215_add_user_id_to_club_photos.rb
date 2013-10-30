class AddUserIdToClubPhotos < ActiveRecord::Migration
  def change
    add_column :club_photos, :user_id, :integer
  end
end
