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
    club = Club.find params[:club_id] if params[:club_id]
    @event = club ? club.events.new(params[:event]) : @university.events.new(params[:event])
    @event.user_id = current_user.id
    if @event.save
      redirect_to university_path(@university), notice: "Event was created successfully"
    else
      load_university_data
      render :show
    end
  end
end
