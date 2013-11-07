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

  def create_free_food_event
    @university = University.find(params[:id])
    @event = @university.events.new(params[:event])
    @event.user_id = current_user.id
    if @event.save
      redirect_to university_path(@university), notice: "Event was created successfully"
    else
      load_university_data
      render :show
    end
  end

  def update_free_food_event
    @university = University.find(params[:id])
    @event = Event.find(params[:event_id])
    if @event.update_attributes(params[:event])
      redirect_to university_path(@university), notice: "Event was updated successfully"
    else
      load_university_data
      render :show
    end
  end

  def search_events
    @university = University.find(params[:id])
    @free_food_events = @university.events.search_date(params[:on_date]).free_food.order(:at_time)
    session[:on_date] = params[:on_date]
    respond_to :js
  end
    
end
