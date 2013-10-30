class CommentsController < ApplicationController

  before_filter :find_update

  def index
    render json: @update.comments
  end

  def create
    @comment = @update.comments.new(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save 
      respond_to do |format|
        format.html { redirect_to university_club_path(@update.updateable.university, @update.updateable) }
        format.json { render json: @comment}
      end
    end
  end

  private
  
  def find_update
    @update = Update.find(params[:update_id])
  end

end
