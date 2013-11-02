class CommentsController < ApplicationController

  before_filter :find_update

  def index
    render json: @update.comments
  end

  def create
    @comment = @update.comments.new(params[:comment])
    @comment.user_id = current_user.id
    @comment.save
    respond_to :js
  end

  private
  
  def find_update
    @update = Update.find(params[:update_id])
  end

end