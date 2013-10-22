class CreateContactRequirements < ActiveRecord::Migration
  def change
    create_table :contact_requirements do |t|
      t.integer :profile_id
      t.string :gpa_requirement
      t.string :major_requirement
      t.string :years_working_experience
      t.string :fields_of_interest
      t.timestamps
    end
  end
end
