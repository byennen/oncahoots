class Admin::DashboardController < Admin::ApplicationController
  def index
    unless current_user.super_admin? || current_user.university_admin?
      redirect_to root_path
    end
  end
end
