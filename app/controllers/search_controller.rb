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

  def results
    if params[:object]=="student"
      search_user(false)
    elsif params[:object]=="alumni"
      search_user(true)
    elsif params[:object]=="club"
      search_club
    elsif params[:object]=='event'
      search_event
    end
  end

  private
    def load_university
      @university=params[:university_id] ? University.find(params[:university_id]) : current_user.university
    end

    def search_event
      events = current_user.super_admin? ? Event : current_user.university.events
      @events = events.search_all(params[:event].merge(title: params[:terms]))
      @count = @events.size
    end

    def search_club
      clubs = current_user.super_admin? ? Club.sup_club : current_user.university.clubs.sup_club
      @clubs = clubs.search_all(params[:club].merge(name: params[:terms]))
      @count = @clubs.size
    end

    def search_user(alumni)
      users = current_user.super_admin? ? User : current_user.university.users
      users = users.alumni if alumni
      @users = users.search_all(params[:user].merge(name: params[:terms]))
      @count = @users.size
    end
end
