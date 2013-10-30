class Admin::ApplicationController < ApplicationController

  layout 'admin'

  def authorize_admin
    authorize! :manage, :admin_pages
  end

end
