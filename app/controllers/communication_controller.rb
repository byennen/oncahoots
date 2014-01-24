class CommunicationController < ApplicationController
  def index
    @conversations = current_user.mailbox.inbox
    @unread_messages = current_user.mailbox.inbox(unread: true)
    @notices = current_user.alert_user_notifications.where(unread: true)
    @requests = current_user.relationships.where("status IN (?)", ['pending', 'recommended'])
  end
end
