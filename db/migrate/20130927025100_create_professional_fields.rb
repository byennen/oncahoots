class CreateProfessionalFields < ActiveRecord::Migration
  def change
    create_table :professional_fields do |t|
      t.string :name
      t.timestamps
    end
  end
end
