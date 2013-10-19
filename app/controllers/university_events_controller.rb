class UniversityEventsController < ApplicationController

  before_filter :ensure_user_university

  def index
    @university_events = @university.events.all
  end

  def show
    @university_event = @university.events.find(params[:id])
  end

  def create    
    @university_event = @university.events.new(params["/universities/#{params[:university_id]}/calendar"])
    if @university_event.save
      respond_to do |format|
        format.html { redirect_to university_university_event_path(@university, @university_event)}
      end
    end
  end

  def update
    @club_event = @university.events.find(params[:id])
    @club_event.attributes = params[:club_event]
    if @club_event.save
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club) }
      end
    end
  end

  def destroy
    @university_event = @university.events.find(params[:id])
    if @university_event.destroy
      respond_to do |format|        
        format.html { redirect_to university_university_events_path(@university) }
      end
    end
  end

  private

    def ensure_user_university
      @university = University.find(params[:university_id])
      unless current_user.university == @university
        redirect_to university_path(params[:university_id])
      else
        return true
      end
    end

end
