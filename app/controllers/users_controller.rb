class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @profile = @user.profile
    @experiences = @profile.experiences
    @invitations = Invitation.where(recipient_id: current_user.id)
  end
end