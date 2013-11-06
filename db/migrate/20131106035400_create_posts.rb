class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.belongs_to :club
      t.belongs_to :user

      t.timestamps
    end
    add_index :posts, :club_id
    add_index :posts, :user_id
  end
end
