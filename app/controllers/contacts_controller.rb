class ContactsController < ApplicationController

  def index
    @user = current_user
    @contacts = @user.contacts   
  end

  def search
    contacts = current_user.contacts.where("lower(first_name) like ? or lower(last_name) like ?", "%#{params[:term].downcase}%", "%#{params[:term].downcase}%")
    return_auto_json(contacts)
  end

  def multi_search
    @contacts = current_user.contacts.search_all(params[:user])
    respond_to :js
  end
end
