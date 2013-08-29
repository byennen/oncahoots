class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  #password for staging
  if (ENV["RAILS_ENV"] == "staging")
    before_filter :verifies_staging_user
  end

  def verifies_staging_user
    unless cookies[:cahoots_connect]
      authenticate_or_request_with_http_basic do |username, password|
        username == "cahoots" && password == "cahoots2013"
        cookies[:cahoots_connect] = {:value => "staging", :expires => 5.days.from_now.utc, :domain => :all}
      end
    end
  end

  # Idea for profiles -Lance
  #before_filter :checks_for_users_profile
  #def checks_for_users_profile
  #  unless current_user.profile.skills.present?
  #    redirect_to edit_user_profile_url(current_user, current_user.profile), notice: 'Please finish filling out your profile.'
  #  end
  #end

end
