class Admin::ApplicationController < Admin::ApplicationController

  before_filter :authenticate_user!

  #layout 'admin'

  def authorize_admin
    authorize! :manage, :admin_pages
  end

end
