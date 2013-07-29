class HomeController < ApplicationController
  def index
    @users = User.all
    @universities = University.all
  end
end
