class HomeController < ActionController::Base
  layout 'sessions'

  def index
    if current_user
      redirect_to university_path(current_user.university)
    end
  end
end
