class PostsController < ApplicationController

  before_filter :load_data, except: [:destroy]

   def comment
    @post = Post.find(params[:id])
    @comment = @post.comments.new(params[:comment])
    @comment.save
    respond_to :js
  end

  def create
    @post = current_user.posts.build(params[:post])
    @post.save
    respond_to :js
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to :js
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    respond_to :js
  end

  private
    def load_data
      @metropolitan_club = MetropolitanClub.find(params[:post][:club_id])
    end
end
