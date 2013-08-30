class ClubsController < ApplicationController

  def show
    @club = Club.find(params[:id])
    @university = University.find(params[:university_id])
    @membership = Membership.new
    @members = @club.users
  end
end
