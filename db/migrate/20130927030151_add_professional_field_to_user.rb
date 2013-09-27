class AddProfessionalFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :professional_field_id, :integer
  end
end
