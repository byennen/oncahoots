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
    current_user.reply_to_conversation(@conversation, params[:message][:body],nil,nil,nil,params[:message][:attachment])
    respond_to do |format|
      format.js { }
    end
  end
  
  def destroy
    if params[:club_id]
      @club = Club.find params[:club_id]
      @conversation = @club.mailbox.inbox.find(params[:id])
      @club.mark_as_deleted @conversation
    else
      @conversation = current_user.mailbox.inbox.find(params[:id])
      current_user.mark_as_deleted @conversation
    end
    respond_to :js
  end

  private 

  def recipients
    @recipient_list
  end

  def find_recipients
    @recipient_list = []
    mems = current_user.super_admin? ? User : current_user.university.users
    @recipient_list |= mems.student if params[:student]
    @recipient_list |= mems.alumni if params[:alumni]

    slugs = params[:message][:recipients].split(',')
    @recipient_list |= User.where(slug: slugs).all unless slugs.blank?
    unless params[:universities].blank?
      uni_slugs = params[:universities].split(',')
      University.where(slug: uni_slugs).each do |university|
        @recipient_list |= university.users.all
      end
    end
    unless params[:clubs].blank?
      club_slugs = params[:clubs].split(',')
      Club.where(slug: club_slugs).each do |club|
        @recipient_list |= club.members.all
      end
    end

    Rails.logger.debug("recipients are #{@recipient_list.inspect}")
  end

end

