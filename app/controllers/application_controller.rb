class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :check_completed_info
  before_filter :load_data
  before_filter :select_tab

  helper_method :load_university_data, :return_auto_json

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  # Idea for profiles -Lance
  #before_filter :checks_for_users_profile
  #def checks_for_users_profile
  #  unless current_user.profile.skills.present?
  #    redirect_to edit_user_profile_url(current_user, current_user.profile), notice: 'Please finish filling out your profile.'
  #  end
  #end

  def load_university_data
    if @university
      @users = @university.users.where("id != 1 AND id != 2")
      @updateable = @university
      @updates = @updateable.updates
      @events = @university.events.active.free_food.search_date(Date.today)
      @clubs = @university.clubs.sup_club.limit(5).order(:name)
      @club ||= @university.clubs.build
      @club_updates = Update.where(updateable_type: "Club").where(updateable_id: @clubs.map(&:id)).order("created_at DESC")
    end
  end

  def load_data
    if current_user
      @messages = current_user.mailbox.conversations
      @requests = current_user.relationships.where(status: 'pending')
    end
  end

  def return_auto_json(objects)
    results = []
    objects.each do |obj|
      results << {id: obj.id, label: obj.name, value: obj.slug}
    end
    respond_to do |format|
      format.json {render json: results}
    end
  end

  def check_completed_info
    redirect_to finish_signup_path if current_user && !current_user.valid?
  end

  def select_tab
    flash[:tab_id] ||= params[:tab_id] if params[:tab_id]
  end
end
