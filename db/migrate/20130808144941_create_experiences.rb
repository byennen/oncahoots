class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :position_name
      t.string :company_name
      t.date :date_started
      t.date :date_ended
      t.integer :profile_id

      t.timestamps
    end
  end
end
