class SearchController < ApplicationController
  before_filter :load_university
  def index
    if params[:term]
      clubs = current_user.super_admin? ? Club : current_user.university.clubs
      users = current_user.super_admin? ? User : current_user.university.users
      events = current_user.super_admin? ? Event : current_user.university.events
      @clubs = clubs.search_name(params[:term])
      @users = users.search_name(params[:term])
      @events = events.search_title(params[:term])
    end
  end

  def club
    clubs = current_user.super_admin? ? Club : current_user.university.clubs
    @clubs = clubs.search_all(params[:club])
    respond_to :js
  end

  def person
    users = current_user.super_admin? ? User : current_user.university.users
    @users = users.search_all(params[:user])
    respond_to :js
  end

  def event
    events = current_user.super_admin? ? Event : current_user.university.events
    @events = events.search_all(params[:event])
  end

  private
    def load_university
      @university=params[:university_id] ? University.find(params[:university_id]) : current_user.university
    end
end
