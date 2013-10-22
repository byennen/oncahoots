class EventsController < ApplicationController
  def index
    @bg_image=""
    @week_start = DateTime.now.beginning_of_week - 1.days
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
end
