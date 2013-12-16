class ChangeCommentsCommentType < ActiveRecord::Migration
  def up
    change_column :comments, :comment, :text
  end

  def down
  end
end
