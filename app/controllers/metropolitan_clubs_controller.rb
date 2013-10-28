class MetropolitanClubsController < ApplicationController
  def show
    @metropolitan_club = current_user.metropolitan_club
    @updateable = @metropolitan_club
    @updates = @updateable.updates
  end
end
