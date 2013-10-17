class UsersController < ApplicationController
 
  def search
    users = User.where("lower(first_name) like ? or lower(last_name) like ?", "%#{params[:term].downcase}%", "%#{params[:term].downcase}%")
    results = []
    users.each do |user|
      results << {id: user.id, label: user.full_name, value: user.full_name}
    end
    respond_to do |format|
      format.json {render json: results}
    end
  end

  def show
    @user = User.find params[:id]
    @profile = @user.profile
    @experiences = @profile.experiences
    @portfolio_items = @profile.portfolio_items
    @contacts = @user.relationships.where(status: 'accepted')
    if @user == current_user
      @invitations = Invitation.where(recipient_id: current_user.id)
      @messages = current_user.mailbox.conversations
      @unread_messages = current_user.mailbox.inbox(unread: true)
      @requests = current_user.relationships.where("status IN (?)", ['pending', 'recommended'])
      @contacts = current_user.relationships.where(status: 'accepted')
    end
  end
end
