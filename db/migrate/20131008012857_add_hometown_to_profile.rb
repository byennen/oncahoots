class AddHometownToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :hometown, :string
  end
end
