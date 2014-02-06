class RegistrationsController < Devise::RegistrationsController
  layout 'sessions', except: [:edit]
  skip_before_filter :check_completed_info, except: [:edit]

  def destroy
    current_user.destroy
    redirect_to root_path
  end

  def edit
    @full_page = true
    super
  end

  def finish
    @user = current_user
    redirect_to root_path if @user.valid?
  end

  def update
    @user = current_user
    if @user.valid?
      if @user.update_with_password(params[:user])
        sign_in(@user, bypass: true)
        redirect_to edit_user_registration_path, notice: "Update Successfully"
      else
        redirect_to edit_user_registration_path, alert: @user.errors.full_messages.join("<br>")
      end
    else
      if @user.update_attributes(params[:user])
        sign_in(@user, bypass: true)
        redirect_to edit_user_profile_path(current_user, current_user.profile)
      else
        render :finish
      end
    end
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    root_path
  end

  def after_sign_up_path_for(resource)
    edit_user_profile_path(current_user, current_user.profile)
  end
end
