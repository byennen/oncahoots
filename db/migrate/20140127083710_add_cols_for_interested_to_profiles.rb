class AddColsForInterestedToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :interested1, :string
    add_column :profiles, :interested2, :string
    add_column :profiles, :interested3, :string
  end
end
