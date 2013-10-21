class ProfilesController < ApplicationController
  respond_to :html

  def new
    @profile = Profile.new
  end

  def edit
    @profile = current_user.profile
    @bg_image = ""
  end

  def show
    @user = User.find_by_id(params[:user_id]) || current_user
    @messages = @user.mailbox.conversations
    @unread_messages = @user.mailbox.inbox(unread: true)
    @requests = @user.relationships.where(status: 'pending')
    @contacts = @user.relationships.where(status: 'accepted')
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

  def upload_avatar
    @profile = current_user.profile
    @profile.update_attributes(params[:profile])
    redirect_to edit_user_profile_path(current_user, @profile)
  end

  def skip
    @profile = Profile.create(user_id: current_user.id)
    redirect_to university_path(current_user.university_id), notice: 'Profile was successfully created.'
  end

end
