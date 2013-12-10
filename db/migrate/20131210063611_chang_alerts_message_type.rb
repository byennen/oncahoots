class ChangAlertsMessageType < ActiveRecord::Migration
  def up
    change_column :alerts, :message, :text
  end

  def down
  end
end
