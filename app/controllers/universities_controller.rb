class UniversitiesController < ApplicationController

  def index
    @universities = University.all
  end

  def show
    @university = University.find(params[:id])
    @users = User.find_all_by_university_id(@university.id)
    @updates = @university.updates.all
  end
end
