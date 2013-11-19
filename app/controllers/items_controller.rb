class ItemsController < ApplicationController
  def create
    @club = Club.find params[:club_id]
    @club.items.build(params[:item])
    @club.save
    respond_to :js
  end
end