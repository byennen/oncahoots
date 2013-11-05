class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :load_data
  helper_method :load_university_data

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
      @bg_style = "background-image: url('#{@university.banner.url}')" unless @university.banner.blank?
      @users = @university.users.where("id != 1 AND id != 2")
      @updateable = @university
      @updates = @updateable.updates
      @free_food_events = @university.events.free_food.order(:on_date, :at_time).reverse_order + @university.club_events.free_food.order(:on_date, :at_time).reverse_order
      @university_events = @university.events.all
      @update = Update.new
      @clubs = @university.clubs.order(:name)
      @club ||= @university.clubs.build
      @club_updates = Update.where(updateable_type: "Club").where(updateable_id: @clubs.map(&:id)).order("created_at DESC").all
    end
  end

  def load_data
    if current_user
      @messages = current_user.mailbox.conversations
      @requests = current_user.relationships.where(status: 'pending')
    end
  end

end
