class TransactionsController < ApplicationController
  def index
    @club = Club.find(params[:club_id])
    @item = Item.new
  end
end