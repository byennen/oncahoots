class UniversitiesController < ApplicationController

  def index
    @universities = University.all
  end

  def home
    @university = current_user.university
    load_details_data
    render :show
  end

  def show
    @university = University.find(params[:id])
    load_details_data
  end

  private
    def load_details_data
      @users = @university.users
      @updateable = @university
      @updates = @updateable.updates
      @update = Update.new

      @clubs = @university.clubs.order(:name)
      @club_updates = Update.where(updateable_type: "Club").where(updateable_id: @clubs.map(&:id)).order("created_at DESC").all
    end
end
