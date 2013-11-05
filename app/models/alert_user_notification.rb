class AlertUserNotification < ActiveRecord::Base
  attr_accessible :user_id, :alert_id

  belongs_to :alert
  belongs_to :user

end
