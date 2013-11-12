class ClubEventsController < ApplicationController

  before_filter :ensure_club

  def create
    @event = @club.events.new(params[:event])
    @event.university_id = @club.university_id
    if @event.save
      redirect_to university_club_path(@university, @club)
    else
      club_init
      render :template => university_club_path(@university, @club)
    end
  end

  def update
    @event = @club.events.find(params[:id])
    if @club.update_attributes(params[:club])
      redirect_to university_club_path(@university, @club), alert: "access denied."
    else
      club_init
      render :template => university_club_path(@university, @club)
    end
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
      if current_user.manage_club?(@club)
        true
      else
        redirect_to university_club_path(@university, @club), alert: "access denied."
      end
    end

    def club_init
      @university = @club.university
      @membership = Membership.new
      @members = @club.users
      @memberships = @club.memberships
      @current_membership = @club.memberships.find_by_user_id(current_user.id)
      @admins = @club.memberships.where(admin: true)
      @conversations = current_user.manage_club?(@club) ? @club.mailbox.inbox : current_user.conversations_for(@club)
      @invitation = Invitation.new
      @event ||= Event.new
    end
end
