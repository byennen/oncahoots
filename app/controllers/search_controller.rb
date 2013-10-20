class SearchController < ApplicationController
  before_filter :load_university
  def index
    @bg_image=""
  end

  def club
    @clubs = Club.search_all(params[:club])
    respond_to :js
  end

  def person
    @users = User.search_all(params[:user])
    respond_to :js
  end

  private
    def load_university
      @university=params[:university_id] ? University.find(params[:university_id]) : current_user.university
    end
end
