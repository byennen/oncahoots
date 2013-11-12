class ContactsController < ApplicationController

  def index
    @user = current_user
    @contacts = @user.contacts   
  end

  def search
    contacts = current_user.relations.where("lower(first_name) like ? or lower(last_name) like ?", "%#{params[:term].downcase}%", "%#{params[:term].downcase}%")
    results = []
    contacts.each do |user|
      results << {id: user.id, label: user.name, value: user.slug} if Relationship.reciprocal?(current_user, user)
    end
    respond_to do |format|
      format.json {render json: results}
    end
  end

  def multi_search
    @contacts = current_user.contacts.search_all(params[:user])
    respond_to :js
  end
end
