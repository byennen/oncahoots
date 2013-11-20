class ItemsController < ApplicationController
  def create
    @club = Club.find params[:club_id]
    @item = @club.items.build(params[:item])
    @item.save
    respond_to :js
  end
end