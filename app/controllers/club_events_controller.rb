class ClubEventsController < ApplicationController

  before_filter :ensure_user_university
  before_filter :ensure_user_club

  def create
    @club_event = @club.club_events.new(params[:club_event])
    if @club_event.save
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club) }
      end
    end
  end

  def update
    @club_event = @club.club_events.find(params[:id])
    @club_event.attributes = params[:club_event]
    if @club_event.save
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club) }
      end
    end
  end

  def destroy
    @club_event = @club.club_events.find(params[:id])
    if @club_event.destroy
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club) }
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

    def ensure_user_club
      @club = @university.clubs.find(params[:club_id])
      unless current_user.id == @club.user_id
        redirect_to club_path(params[:club_id])
      else
        return true
      end
    end

end
