class UniversitiesController < ApplicationController
  layout "static"
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

  def search_events
    @university = University.find(params[:id])
    @free_food_events = @university.events.search_date(params[:on_date]).free_food.order(:at_time)
    session[:on_date] = params[:on_date]
    respond_to :js
  end
    
  def auto_search
    universities = University.where("lower(name) like ?", "%#{params[:term].downcase}%")
    return_auto_json(universities)
  end

  def update
    @university = University.find params[:id]
    @university.update_attributes(params[:university])
    respond_to do |format|
      format.html {redirect_to university_path(@university)}
      format.js
    end
  end
end