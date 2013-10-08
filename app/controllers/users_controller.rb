class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @profile = @user.profile
    @experiences = @profile.experiences
    @invitations = Invitation.where(recipient_id: current_user.id)
    @portfolio_items = @profile.portfolio_items
    @messages = current_user.mailbox.conversations
    @unread_messages = current_user.mailbox.inbox(unread: true)
    @requests = current_user.relationships.where(status: 'pending')
    @contacts = current_user.relationships.where(status: 'accepted')    
  end
end
