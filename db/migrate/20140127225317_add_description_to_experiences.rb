class AddDescriptionToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :description, :text
  end
end
