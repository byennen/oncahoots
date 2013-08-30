class MembershipsController < ApplicationController


  def create
    @club = Club.find(params[:club_id])
    @university = University.find(params[:university_id])
    @membership = Membership.new(user_id: current_user.id, club_id: @club.id)
    if @membership.save
      redirect_to university_club_path(@university, @club), notice: 'Membership was successfully created.'
    else
      redirect_to university_club_path(@university, @club), notice: 'Membership failed.'
    end
  end
end
