class ClubEventsController < ApplicationController

  before_filter :ensure_club, except: [:week_events]

  def create
    @event = @club.events.new(params[:event])
    @event.user_id = current_user.id
    @event.university_id = @club.university_id
    @event.save
  end

  def update
    @event = @club.events.find(params[:id])
    @event.update_attributes(params[:event])
  end

  def destroy
    @event = @club.events.find(params[:id])
    if @event.destroy
      respond_to do |format|
        format.html {redirect_to :back}
        format.json {render json: true}
      end
    else
      club_init
      respond_to do |format|
        format.html {render :template => university_club_path(@university, @club)}
        format.json {render json: @club, status: 422}
      end
    end
  end

  def week_events
    @club=Club.find params[:club_id]
    @w_begin = Date.strptime(params[:w_begin],"%y%m%d")
    @events = @club.events.where(on_date: @w_begin..(@w_begin+6.days))
    respond_to :js
  end

  private
    def ensure_club
      @club = Club.find params[:club_id]
      if current_user.member_of?(@club) || current_user.manage_club?(@club)
        true
      else
        redirect_to university_club_path(@university, @club), alert: "access denied."
      end
    end
end
