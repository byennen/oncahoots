class RenameClubEventsToEvents < ActiveRecord::Migration
  def up
    rename_table :club_events, :events
    add_column :events, :free_food, :boolean
    add_column :events, :eventable_id, :integer
    add_column :events, :eventable_type, :string      
  end

  def down
    rename_table :events, :club_events
    remove_column :events, :free_food, :boolean
    remove_column :events, :eventable_id, :integer
    remove_column :events, :eventable_type, :string          
  end
end