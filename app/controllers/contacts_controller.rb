class ContactsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @contacts = @user.relationships.accepted
  end

end
