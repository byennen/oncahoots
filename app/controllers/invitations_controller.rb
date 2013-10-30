class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
    @university = University.find(params[:university_id])
    @club = Club.find(params[:club_id])
    @users = User.find_by_university_id(@university.id)
  end

  def create
    @university = University.find(params[:university_id])
    @club = @university.clubs.find(params[:club_id])
    @recipient = User.find(params[:invitation][:recipient_id])
    Invitation.create(sender_id: current_user.id, recipient_id: @recipient.id, club_id: @club.id)
    redirect_to university_club_path(@university, @club)
  end

  def search
    users = University.find(params[:university_id]).users.where("lower(first_name) like ? or lower(last_name) like ?", "%#{params[:term].downcase}%", "%#{params[:term].downcase}%")
    club = Club.find params[:club_id]
    results = []
    users.each do |user|
      results << {id: user.id, label: user.full_name, value: user.slug} unless (user.join_club?(club) || current_user == user)
    end
    respond_to do |format|
      format.json {render json: results}
    end
  end
end
