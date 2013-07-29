class UniversitiesController < ApplicationController

  def index
    @universities = University.all
  end

  def show
    @university = University.find(params[:id])
  end
end
