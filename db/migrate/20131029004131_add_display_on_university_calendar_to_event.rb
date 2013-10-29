class AddDisplayOnUniversityCalendarToEvent < ActiveRecord::Migration
  def change
    add_column :events, :display_on_uc, :boolean
  end
end
