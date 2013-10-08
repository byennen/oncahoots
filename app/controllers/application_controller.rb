class ApplicationController < ActionController::Base
  before_filter :authenticate_user!

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  # Idea for profiles -Lance
  #before_filter :checks_for_users_profile
  #def checks_for_users_profile
  #  unless current_user.profile.skills.present?
  #    redirect_to edit_user_profile_url(current_user, current_user.profile), notice: 'Please finish filling out your profile.'
  #  end
  #end

end
