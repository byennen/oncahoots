class ChangeEventsField < ActiveRecord::Migration
  def up
    add_column :events, :on_date, :date
    add_column :events, :at_time, :time
    change_column :events, :description, :text
  end

  def down
  end
end
