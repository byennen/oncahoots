class CommentsController < ApplicationController

  before_filter :find_resource

  def index
    render json: @resource.comments
  end

  def create
    @comment = @resource.comments.new(params[:comment])
    @comment.user_id = current_user.id
    @comment.save
    respond_to :js
  end

  private
  
  def find_resource
    @resource = Update.find(params[:update_id]) if params[:update_id]
    @resource = Post.find params[:post_id] if params[:post_id]
  end

end