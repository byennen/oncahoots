class ClubsController < ApplicationController

  before_filter :authenticate_user!, except: [:show]
  before_filter :ensure_user_university, except: [:show]

  def show
    @university = University.find(params[:university_id])
    @club = @university.clubs.find(params[:id])
    @membership = Membership.new
    @members = @club.users
  end

  def new
    @club = @university.clubs.new
  end

  def create
    @club = @university.clubs.new(params[:club])
    if @club.save
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club) }
      end
    else
      respond_to do |format|
        format.html { render action: :new }
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
