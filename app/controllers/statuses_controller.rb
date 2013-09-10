class StatusesController < ApplicationController

  before_filter :find_university
  before_filter :find_club

  def create
    @status = @club.statuses.new(params[:status])
    @status.user_id = current_user.id
    if @status.save
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club), notice: "Lowdown created" }
      end
    end
  end

  def destroy
    @status = @club.statuses.find(params[:id])
    if @status.destroy
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club), notice: "Lowdown deleted" }
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
