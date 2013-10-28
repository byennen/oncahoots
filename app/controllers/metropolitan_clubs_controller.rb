class MetropolitanClubsController < ApplicationController
  def show
    @metropolitan_club = current_user.metropolitan_club
  end
end
