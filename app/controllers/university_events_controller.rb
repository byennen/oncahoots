class UniversityEventsController < ApplicationController

  before_filter :ensure_user_university, except: [:load_events, :next_week, :prev_week]

  def create
    @university = University.find(params[:university_id])
    @event = @university.events.new(params[:event])
    @event.user_id = current_user.id
    @event.save
    respond_to :js
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_to :js
  end

  def index
    @event = Event.new
    init
  end

  def load_events
    day=Date.strptime(params[:day],"%y%m%d")
    @events = events_of_day(day)
    respond_to :js
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

    def events_of_day(day)
      current_user.university.events.where(on_date: day)
    end

    def init
      @event ||=Event.new
      @week_start = DateTime.now.beginning_of_week - 1.days
      @university_events = @university.events.all
      @university_clubs  = @university.clubs.order(:name)
      @events = events_of_day(Date.today)
    end

end
