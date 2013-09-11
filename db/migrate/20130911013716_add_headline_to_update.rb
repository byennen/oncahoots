class AddHeadlineToUpdate < ActiveRecord::Migration
  def change
    add_column :updates, :headline, :string
  end
end
