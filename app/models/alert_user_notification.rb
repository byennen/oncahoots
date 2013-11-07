class AlertUserNotification < ActiveRecord::Base
  attr_accessible :user_id, :alert_id

  belongs_to :alert
  belongs_to :user


  def mark_as_read!
    update_attribute(:unread, false)
  end

end
