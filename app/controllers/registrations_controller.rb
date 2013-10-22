class RegistrationsController < Devise::RegistrationsController
  layout 'sessions', except: [:edit]

  def edit
    @bg_image = ""
    super
  end

  protected

  def after_sign_up_path_for(resource)
    edit_user_profile_path(current_user, current_user.profile)
  end
end
