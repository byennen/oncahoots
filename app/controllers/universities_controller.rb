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
    club = Club.find params[:club_id] unless params[:club_id].blank?
    @event = club ? club.events.new(params[:event]) : @university.events.new(params[:event])
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
    club = Club.find params[:club_id] unless params[:club_id].blank?
    @event = Event.find(params[:event_id])
    @event.eventable = club ? club : @university
    if @event.update_attributes(params[:event])
      redirect_to university_path(@university), notice: "Event was updated successfully"
    else
      load_university_data
      render :show
    end
  end

  def search_events
    @university = University.find(params[:id])
    @free_food_events = @university.events.search_date(params[:on_date]).free_food.order(:at_time).reverse_order + 
           @university.club_events.search_date(params[:on_date]).free_food.order(:at_time).reverse_order
    session[:on_date] = params[:on_date]
  end

end
