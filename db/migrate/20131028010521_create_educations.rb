class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.integer :profile_id
      t.string :completed
      t.string :major
      t.string :university
      t.string :degree_type
      t.string :graduation_year
      t.string :high_school
      t.timestamps
    end
  end
end
