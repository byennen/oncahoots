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
      search_user("student")
    elsif params[:object]=="alumni"
      search_user("alumni")
    elsif params[:object]=="club"
      search_club
    elsif params[:object]=='event'
      search_event
    else
      search_event
      search_club
      search_user('all')
    end
    respond_to do |format|
      format.html
      format.json {
        render json: auto_json((@users.to_a))
      }
    end
  end

  private
    def load_university
      @university=params[:university_id] ? University.find(params[:university_id]) : current_user.university
    end

    def search_event
      params[:event]||={}
      events = current_user.super_admin? ? Event : current_user.university.events
      @events = events.search_all(params[:event].merge(title: params[:term])).order(:title).limit(50) #avoids denial of service attacks
    end

    def search_club
      params[:club]||={}
      clubs = current_user.super_admin? ? Club : current_user.university.clubs
      @clubs = clubs.search_all(params[:club].merge(name: params[:term])).order(:name).limit(50) #avoids denial of service attacks
    end

    def search_user(utype)
      params[:user]||={}
      users = current_user.super_admin? ? User : current_user.university.users
      users = users.alumni if utype=='alumni'
      users = users.student if utype=='student'
      params[:term] ||= params[:user][:name] if params[:term].blank?
      @users = users.search_all(params[:user].reverse_merge(name: params[:term])).order(:first_name).limit(50) #avoids denial of service attacks
    end

    def auto_json(objects)
      objects.map do |obj|
        {id: obj.id, label: obj.name, value: obj.name, slug: obj.slug}
      end
    end

end
