class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
    @university = University.find(params[:university_id])
    @club = Club.find(params[:club_id])
    @users = User.find_by_university_id(@university.id)
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    @club = Club.find(params[:club_id])
    @invitation.update_attributes(club_id: @club.id)
    if @invitation.save
      #Mailer.deliver_invitation(@invitation, signup_url(@invitation.token))
      flash[:notice] = "Thank you, invitation sent."
      redirect_to root_path
    else
      flash[:notice] = "Invitations failed."
      render :action => 'new'
    end
  end

end
