class CommunicationController < ApplicationController
  def index
    @conversations = current_user.mailbox.inbox.order("created_at DESC")
    @unread_messages = current_user.mailbox.inbox(unread: true).order("created_at DESC")
    @notices = current_user.alert_user_notifications.where(unread: true).order("created_at DESC")
    @requests = current_user.relationships.where("status IN (?)", ['pending', 'recommended']).order("created_at DESC")
  end
end
