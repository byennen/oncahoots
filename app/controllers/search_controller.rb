class SearchController < ApplicationController
  before_filter :load_university
  def index
    if params[:term]
      @clubs = Club.search_name(params[:term])
      @users = User.search_name(params[:term])
      @events = Event.search_title(params[:term])
    end
  end

  def club
    @clubs = Club.search_all(params[:club])
    respond_to :js
  end

  def person
    @users = User.search_all(params[:user])
    respond_to :js
  end

  def event
    @events = Event.search_all(params[:event])
  end

  private
    def load_university
      @university=params[:university_id] ? University.find(params[:university_id]) : current_user.university
    end
end
