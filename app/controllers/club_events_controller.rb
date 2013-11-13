class ClubEventsController < ApplicationController

  before_filter :ensure_club

  def create
    @event = @club.events.new(params[:event])
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
      redirect_to university_club_path(@university, @club)
    else
      club_init
      render :template => university_club_path(@university, @club)
    end
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
