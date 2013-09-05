class HomeController < ApplicationController
  def index
    @users = User.all
    if current_user
      @universities = [current_user.university]
    else
      @universities = University.all
    end
  end
end
