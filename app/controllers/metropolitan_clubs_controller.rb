class MetropolitanClubsController < ApplicationController
  
  def home
    @university = current_user.university
    @metropolitan_club = current_user.metropolitan_club
    unless @metropolitan_club
      redirect_to edit_user_profile_path(current_user, current_user.profile), notice: "please update your current city"
    else
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
    @university = @metropolitan_club.university
  end

end
