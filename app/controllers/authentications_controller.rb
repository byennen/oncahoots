class AuthenticationsController < ApplicationController
  def create
    omniauth = request.env["omniauth.auth"]
    access_token = omniauth['credentials']['token']
    session[:token] = access_token if omniauth['provider']=='facebook'
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)      
    elsif current_user
      current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to root_path
    else
      puts omniauth["extra"]["raw_info"]
      user = User.find_or_create_by_email(omniauth["extra"]["raw_info"]["email"] || omniauth["extra"]["raw_info"]["emailAddress"] || "#{omniauth["extra"]["raw_info"]["name"].gsub(" ", "_").downcase}@#{omniauth['uid']}.#{omniauth['provider']}")
      if user.new_record?
        password = (0...8).map{65.+(rand(25)).chr}.join
        user.password = password 
        user.password_confirmation = password
        user.name = omniauth["extra"]["raw_info"]["name"]
        user.provider = omniauth ['provider']
      end
      user.name = omniauth["extra"]["raw_info"]["name"] unless user.name
      user.authentications.build(:provider => omniauth ['provider'], :uid => omniauth['uid'])
      user.save!
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, user)
    end
    
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to root_path
  end
end