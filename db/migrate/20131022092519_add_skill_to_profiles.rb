class AddSkillToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :skill1, :string
    add_column :profiles, :skill2, :string
    add_column :profiles, :skill3, :string
  end
end
