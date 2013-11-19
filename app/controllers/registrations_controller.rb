class RegistrationsController < Devise::RegistrationsController
  layout 'sessions', except: [:edit]
  skip_before_filter :check_completed_info

  def edit
    super
  end

  def finish
    @user = current_user
    redirect_to root_path if @user.valid?
  end

  def update
    @user = User.find params[:user_id]
    if @user.update_attributes(params[:user])
      sign_in(@user, bypass: true)
      redirect_to edit_user_profile_path(current_user, current_user.profile)
    else
      render :finish
    end
  end

  protected

  def after_sign_up_path_for(resource)
    edit_user_profile_path(current_user, current_user.profile)
  end
end
