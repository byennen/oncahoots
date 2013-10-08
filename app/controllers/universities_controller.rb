class UniversitiesController < ApplicationController

  def index
    @universities = University.all
  end

  def home
    @university = current_user.university
  end

  def show
    @university = University.find(params[:id])
    @users = @university.users

    #@updates = @university.updates.all
    @updateable = @university
    @updates = @updateable.updates
    @update = Update.new

    @clubs = @university.clubs.order(:name)
    @club_updates = Update.where(updateable_type: "Club").where(updateable_id: @clubs.map(&:id)).order("created_at DESC").all
  end
end
