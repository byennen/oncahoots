class UniversitiesController < ApplicationController

  def index
    @universities = University.all
  end

  def home
    @university = current_user.university
    load_university_data
    render :show
  end

  def show
    @university = University.find(params[:id])
    load_university_data
  end

end
