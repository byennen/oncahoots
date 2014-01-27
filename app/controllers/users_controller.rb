class UsersController < ApplicationController

  def search
    if current_user.super_admin?
      users = User.where("lower(first_name) like ? or lower(last_name) like ?", "%#{params[:term].downcase}%", "%#{params[:term].downcase}%")
    else
      users = current_user.university.users.where("lower(first_name) like ? or lower(last_name) like ?", "%#{params[:term].downcase}%", "%#{params[:term].downcase}%")
    end
    return_auto_json(users)
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
      create_notification
      redirect_to edit_user_profile_path(current_user, current_user.profile), notice: "Profile was successfully updated" if !request.xhr?
    else
      @profile = current_user.profile
      @contact_requirements = @profile.contact_requirement.present? ? @profile.contact_requirement : @profile.build_contact_requirement
      render controller: :profile, action: :edit if !request.xhr?
    end
  end

  private

  def create_notification
    Alert.create_user_update(current_user, params[:user])
  end
end
