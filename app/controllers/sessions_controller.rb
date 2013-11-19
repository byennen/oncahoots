class SessionsController < Devise::SessionsController
  layout 'sessions'
  skip_before_filter :check_completed_info
end
