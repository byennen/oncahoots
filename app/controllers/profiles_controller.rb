class ProfilesController < ApplicationController
  respond_to :html

  def new
    @profile = Profile.new
  end

  def edit
    @profile = Profile.find(params[:id])
  end


  def create
    @profile = Profile.new(params[:profile])
    @profile.user_id = current_user.id
    if @profile.save
      redirect_to user_path(current_user), notice: 'Profile was successfully created.'
    else
      format.html { render action: "new" }
    end
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      redirect_to user_path(current_user), notice: 'Profile was successfully updated.'
    else
      format.html { render action: "edit" }
    end
  end

end
