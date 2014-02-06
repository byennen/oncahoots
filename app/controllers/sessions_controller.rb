class SessionsController < Devise::SessionsController
  layout 'sessions'
  skip_before_filter :check_completed_info

  protected

    def after_inactive_sign_up_path_for(resource)
      root_path
    end
end
