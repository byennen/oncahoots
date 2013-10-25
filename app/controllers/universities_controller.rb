class UniversitiesController < ApplicationController

  def create_club
    @university = current_user.university
    @club = @university.clubs.new(params[:club])
    @club.user_id = current_user.id
    if @club.save
      @club.memberships.create(user_id: current_user.id, admin: true)
      redirect_to university_club_path(@university, @club)
    else
      load_details_data
      render :show
    end
  end

  def index
    @universities = University.all
  end

  def home
    @university = current_user.university
    load_university_data
    render :show
  end

  def show
    @university = University.find(params[:id])
    load_university_data
  end

end
