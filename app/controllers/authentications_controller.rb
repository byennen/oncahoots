class AuthenticationsController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def create
    omniauth = request.env["omniauth.auth"]
    access_token = omniauth['credentials']['token']
    if omniauth['provider']  == 'stripe_connect'
      stripe_process omniauth
    else
      athenticate_process omniauth
    end    
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to root_path
  end

  private
    def athenticate_process(omniauth)
      session[:token] = access_token if omniauth['provider']=='facebook'
      authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      puts omniauth.flatten
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

        user.first_name = omniauth["extra"]["raw_info"]["firstName"] unless user.first_name
        user.last_name = omniauth["extra"]["raw_info"]["lastName"] unless user.last_name
        user.authentications.build(:provider => omniauth ['provider'], :uid => omniauth['uid'])
        user.save(validate: false)
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      end
    end

    def stripe_process(omniauth)
      club_id = request.env['omniauth.params']['club_id']
      club = Club.find_by_id club_id
      if current_user && club && current_user.manage_club?(club)
        credential = club.build_stripe_credential(uid: omniauth[:uid], 
          token: omniauth["credentials"]["token"], 
          stripe_publishable_key: omniauth["info"]["stripe_publishable_key"]
        )
        credential.save
        redirect_to club_transactions_path(club)
      end
      redirect_to root_path
    end
end