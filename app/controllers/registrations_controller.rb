class RegistrationsController < Devise::RegistrationsController
  layout 'sessions', except: [:edit]

  def edit
    @bg_image = ""
    super
  end

  protected

  def after_sign_up_path_for(resource)
    new_user_profile_path(current_user)
  end
end
