class MessagesController < ApplicationController

  before_filter :find_recipients, only: [:create]

  def create
    Rails.logger.debug("params are #{params[:message]}")
    #@message = Message.new(params[:message])

    if params[:message][:conversation_id]
      @conversation = Conversation.find(params[:message][:conversation_id])
      unless @conversation.is_participant?(current_user)
        flash[:alert] = "You do not have permission to view that conversation."
        return redirect_to root_path
      end
      receipt = current_user.reply_to_conversation(@conversation, params[:message][:body])
    else
      receipt = current_user.send_message(@recipient_list, params[:message][:body], params[:message][:subject], true, params[:message][:attachment])
      Rails.logger.debug("reciept is #{receipt.inspect}")
    end
    flash[:notice] = "Message sent."
    redirect_to user_path(current_user)
  end
  
  def read
    @conversation = Conversation.find(params[:id])
    unless @conversation.is_participant?(current_user)
      # Don't do anything.
    else
      @conversation.mark_as_read(current_user)
      @unread_messages = current_user.mailbox.inbox(unread: true)
      respond_to do |format|
        format.js { }
      end
    end
  end

  def reply
    @conversation = Conversation.find(params[:id])
    current_user.reply_to_conversation(@conversation, params[:message][:body])
    respond_to do |format|
      format.js { }
    end
  end
  
  private 

  def recipients
    @recipient_list
  end

  def find_recipients
    @recipient_list = []
    params[:message][:recipients].split(',').each do |s|
      name = s.split(" ")
      if name.size > 0
        @recipient_list << User.where(first_name: name[0], last_name: name[1]).first
      end
    end
    Rails.logger.debug("recipients are #{@recipient_list.inspect}")
  end

end

