class MetropolitanClubsController < ApplicationController
  
  def assign_leader
    @metropolitan_club = MetropolitanClub.find params[:id]
    @membership = @metropolitan_club.memberships.build(params[:membership])
    if @membership.save
      @membership.message_leader(metropolitan_club_path(@metropolitan_club))
    end
    @leaderships = @metropolitan_club.memberships.where(admin: true)
    respond_to :js
  end

  def home
    @metropolitan_club = current_user.metropolitan_club
    @membership = Membership.new
    unless @metropolitan_club
      redirect_to edit_user_profile_path(current_user, current_user.profile), notice: "please update your current city"
    else
      init_data
      render :show
    end
  end

  def search_member
    @metropolitan_club = MetropolitanClub.find params[:id]
    @members = @metropolitan_club.members.search_name(params[:user][:name])
    respond_to :js
  end

  def show
    @metropolitan_club = MetropolitanClub.find params[:id]
    @membership = Membership.new
    init_data
  end

  def update
    @metropolitan_club = MetropolitanClub.find params[:id]
    @metropolitan_club.update_attributes(params[:metropolitan_club])
    respond_to :js
  end

  def upload_image
    @metropolitan_club = MetropolitanClub.find params[:id]
    @metropolitan_club.update_attributes(params[:metropolitan_club])
    redirect_to metropolitan_club_path(@metropolitan_club)
  end

  def upload_photo
    @metropolitan_club = MetropolitanClub.find params[:id]
    photo = @metropolitan_club.club_photos.build(params[:club_photo])
    photo.user = current_user
    if photo.save
      redirect_to metropolitan_club_path(@metropolitan_club), notice: "Upload photo successfully"
    else
      redirect_to metropolitan_club_path(@metropolitan_club), error: photo.errors.full_messages.join(", ")
    end
  end

  private
    def init_data
      @university = @metropolitan_club.university
      @leaderships = @metropolitan_club.memberships.where(admin: true)
      @my_photos = @metropolitan_club.club_photos.by_user(current_user)
      @updates = @metropolitan_club.updates
      @updateable = @metropolitan_club
      @posts = @metropolitan_club.posts
      if current_user.manage_club?(@metropolitan_club)
        @conversations = @metropolitan_club.mailbox.inbox
        @sentbox = @metropolitan_club.mailbox.sentbox
      else
        @conversations = current_user.conversations_for(@metropolitan_club)
        @sentbox = current_user.sent_to(@metropolitan_club)
      end
    end 
end
