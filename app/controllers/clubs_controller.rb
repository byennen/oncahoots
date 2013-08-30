class ClubsController < ApplicationController
  load_and_authorize_resource :university
  load_and_authorize_resource :club, :through => :university

  def show
    @club = Club.find(params[:id])
    @membership = Membership.new
    @members = @club.users

  end
end
