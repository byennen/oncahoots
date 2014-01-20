class AlbumsController < ApplicationController
  before_filter :load_resource
  
  def create
    @album = @club.albums.build(params[:album])
    @album.user = current_user
    @album.save
    respond_to :js
  end

  private
    def load_resource
      @club = Club.find params[:club_id]
    end
end