class SessionsController < Devise::SessionsController
  layout 'sessions'
  skip_before_filter :check_completed_info

  def create
    auth_options = { :recall => 'home#index', :scope => :user }
    resource = warden.authenticate!(auth_options)
  end
end
