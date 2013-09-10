class RecordsController < ApplicationController

  before_filter :find_university
  before_filter :find_club

  def create
    if @club.records.create(params[:record])
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club), notice: "Record Created" }
      end
    end
  end

  def destroy
    @record = @club.records.find(params[:id])
    if @record.destroy
      respond_to do |format|
        format.html { redirect_to university_club_path(@university, @club), notice: "Record Deleted" }
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
