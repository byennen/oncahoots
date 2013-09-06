class AddMissionStatementToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :mission_statement, :text
  end
end
