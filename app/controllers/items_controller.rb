class ItemsController < ApplicationController
  before_filter :load_club
  def create
    @item = @club.items.build(params[:item])
    @item.save
    respond_to :js
  end

  def update
    @item = @club.items.find(params[:id])
    @item.update_attributes(params[:item])
    respond_to :js
  end

  private
    def load_club
      @club =  Club.find params[:club_id]
      unless current_user.manage_club?(@club)
        redirect_to club_transactions_path(@club), alert: "access denied!"
      end
    end

end