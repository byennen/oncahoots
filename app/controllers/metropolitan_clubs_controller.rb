class MetropolitanClubsController < ApplicationController
  def show
    @metropolitan_club = current_user.metropolitan_club
    redirect_to edit_user_profile_path(current_user, current_user.profile), notice: "please update your current city" unless @metropolitan_club
  end
end
