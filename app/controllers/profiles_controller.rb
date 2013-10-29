class ProfilesController < ApplicationController
  respond_to :html

  def new
    @profile = Profile.new
    @profile.build_contact_requirement
  end

  def edit
    @user = current_user
    @profile = current_user.profile
    @contact_requirements = @profile.contact_requirement.present? ? @profile.contact_requirement : @profile.build_contact_requirement
    @education = @profile.education.present? ? @profile.education : @profile.build_education
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
    @user = current_user
    @profile = current_user.profile
    if @profile.update_attributes(params[:profile])
      redirect_to edit_user_profile_path(current_user, current_user.profile), notice: 'Profile was successfully updated.'
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

  def contact_requirements
    @profile = current_user.profile
    if @profile.contact_requirement.present?
      @contat_requirement = @profile.contact_requirement
      @contact_requirement.attributes(params[:contact_requirement])
    else
      @contact_requirement = @profile.create_contact_requirement(params[:contact_requirement])
    end
    if @contact_requirement.save
      respond_to do |format|
        format.html { redirect_to edit_user_profile_path(current_user, current_user.profile), notice: "Profile was successfully updated" }
      end
    end
  end

end
