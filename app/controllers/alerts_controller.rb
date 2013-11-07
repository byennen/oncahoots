class AlertsController < ApplicationController

  def read
    @alert_notification = current_user.alert_user_notifications.find_by_alert_id(params[:id])
    @alert_notification.mark_as_read!
    @alert = @alert_notification.alert
    @unread_alerts = current_user.alert_user_notifications.where(unread: true)
  end

end
