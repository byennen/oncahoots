class UsersController < ApplicationController

  def search
    users = User.where("lower(first_name) like ? or lower(last_name) like ?", "%#{params[:term].downcase}%", "%#{params[:term].downcase}%")
    results = []
    users.each do |user|
      results << {id: user.id, label: user.full_name, value: user.slug}
    end
    respond_to do |format|
      format.json {render json: results}
    end
  end

  def filter
    @users = User.search_all(params[:user])
    respond_to :js
  end

  def show
    @user = User.find params[:id]
    @profile = @user.profile
    @experiences = @profile.experiences
    @portfolio_items = @profile.portfolio_items
    @contacts = @user.relationships.where(status: 'accepted')
    if @user == current_user
      @invitations = Invitation.where(recipient_id: current_user.id)
      @conversations = current_user.mailbox.inbox
      @unread_messages = current_user.mailbox.inbox(unread: true)
      @unread_alerts = current_user.alert_user_notifications.where(unread: true)
      @requests = current_user.relationships.where("status IN (?)", ['pending', 'recommended'])
      @contacts = current_user.relationships.where(status: 'accepted')
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to edit_user_profile_path(current_user, current_user.profile)
    else
      @profile = current_user.profile
      @contact_requirements = @profile.contact_requirement.present? ? @profile.contact_requirement : @profile.build_contact_requirement
      render controller: :profile, action: :edit
    end
  end
end
