class StaticPagesController < ActionController::Base
  before_filter :authenticate_user!
  layout 'static'


  # This is just an experiment and will need to be redone for dynamic pages:
  #   using ajax to pass event data to controller
  #   then re-rendering the event_area partial with this data
  def show_event
    @date = params[:event][:date]
    @time = params[:event][:time]
    @location = params[:event][:location]
    @title = params[:event][:title]
    @description = params[:event][:description]

    respond_to do |format|
      format.js {}
    end
  end

end
