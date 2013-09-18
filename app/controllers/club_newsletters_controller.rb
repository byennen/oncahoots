class ClubNewslettersController < ApplicationController

  before_filter :find_university
  before_filter :find_club

  def create
    @update = @club.updates.new(params[:update])
    if @update.save
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club), notice: "Newsletter Creaetd" }
      end
    end
  end

  def update
    @update = @club.updates.find(params[:id])
    @update.attributes = params[:update]
    if @update.save
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club), notice: "Newsletter - #{@update.headline} updated" }
      end
    end
  end

  def destroy
    @update = @club.updates.find(params[:id])
    if @update.destroy
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club), notice: "Newsletter - #{@update.headline} deleted" }
      end
    end
  end

  private

  def find_university
    @university = University.find(params[:university_id])
  end

  def find_club
    @club = @university.clubs.find(params[:club_id])
  end

end
