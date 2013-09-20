class AddViewProfileToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :view_profile, :string
  end
end
