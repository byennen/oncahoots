class ProfilesController < ApplicationController
  respond_to :html

  def new
    @profile = Profile.new
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def show
    @messages = current_user.mailbox.conversations
    @unread_messages = current_user.mailbox.inbox(unread: true)
    @requests = current_user.relationships.where(status: 'pending')
    @contacts = current_user.relationships.where(status: 'accepted')
  end

  def create
    @profile = Profile.new(params[:profile])
    @profile.user_id = current_user.id
    if @profile.save
      redirect_to university_path(current_user.university_id), notice: 'Profile was successfully created.'
    else
      format.html { render action: "new" }
    end
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      redirect_to user_path(current_user), notice: 'Profile was successfully updated.'
    else
      format.html { render action: "edit" }
    end
  end

  def skip
    @profile = Profile.create(user_id: current_user.id)
    redirect_to university_path(current_user.university_id), notice: 'Profile was successfully created.'
  end

end
