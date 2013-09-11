class UniversitiesController < ApplicationController

  def index
    @universities = University.all
  end

  def show
    @university = University.find(params[:id])
    @users = User.find_all_by_university_id(@university.id)

    #@updates = @university.updates.all
    @updateable = @university
    @updates = @updateable.updates
    @update = Update.new

    @clubs = Club.where(university_id: @university.id)
    @club_updates = Update.where(updateable_type: "Club").order("created_at DESC").all
  end
end
