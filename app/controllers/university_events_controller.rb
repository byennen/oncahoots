class UniversityEventsController < ApplicationController

  before_filter :ensure_user_university, except: [:next_week, :prev_week]

  def create    
    @event = @university.events.build(params[:event])
    if @event.save
      redirect_to university_university_event_path(@university, @event)
    else
      init
      render :index
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

  def index
    @event = Event.new
    init
  end

  def next_week
    week_start=Date.strptime(params[:week_start],"%y%m%d")
    @week_start = week_start + 7.days
    render :show_week
  end

  def prev_week
    week_start=Date.strptime(params[:week_start],"%y%m%d")
    @week_start = week_start - 7.days
    render :show_week
  end

  def show
    @event = @university.events.find(params[:id])
  end

  def update
    @event = @university.events.find(params[:id])
    @event.attributes = params[:event]
    if @event.save
      respond_to do |format|
        format.html { redirect_to university_university_events_path(@university)}
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

    def init
      @bg_image=""
      @week_start = DateTime.now.beginning_of_week - 1.days
      @university_events = @university.events.all
    end
end
