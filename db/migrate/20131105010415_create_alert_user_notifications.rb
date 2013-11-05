class CreateAlertUserNotifications < ActiveRecord::Migration
  def change
    create_table :alert_user_notifications do |t|
      t.integer :alert_id
      t.integer :user_id
      t.boolean :unread, default: true
      t.timestamps
    end
  end
end
