class Admin::ClubsController < Admin::ApplicationController
  load_and_authorize_resource

  def index
    @clubs = Club.all
  end

  def new
    @club = Club.new
  end

  def edit
    @club = Club.find(params[:id])
  end

  def create
    if current_user.super_admin?
      @club = Club.new(params[:club])
      @club.update_attributes(user_id: current_user.id)
    end
    if current_user.university_admin?
      @club = Club.new(params[:club])
      @club.update_attributes(university_id: current_user.university_id, user_id: current_user.id)
    end
    if @club.save
      redirect_to admin_clubs_url, notice: 'Club was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @club = Club.find(params[:id])
    if @club.update_attributes(params[:club])
      redirect_to admin_clubs_url, notice: 'Club was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @club = Club.find(params[:id])
    @club.destroy
    redirect_to admin_clubs_url
  end
end
