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

  def create
    build_resource(sign_up_params)

    if resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      redirect_to root_path
    end
  end
  
  protected

  def after_sign_up_path_for(resource)
    edit_user_profile_path(current_user, current_user.profile)
  end
end
