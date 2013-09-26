class AddCityToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :city_id, :integer
  end
end
