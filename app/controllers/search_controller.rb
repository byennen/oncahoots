class SearchController < ApplicationController
  def index
    @bg_image=""
  end

  def club
    
    respond_to :js
  end

  def person

    respond_to :js
  end
end
