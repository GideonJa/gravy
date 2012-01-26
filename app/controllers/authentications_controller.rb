class AuthenticationsController < ApplicationController
  def index
     @authentications = Authentication.all
  end

  def create
    # raise request.env["omniauth.auth"].to_yaml
    omniauth = request.env["omniauth.auth"]
     # authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
     authentication = Authentication.all_of(:uid => omniauth['uid'], :provider => omniauth['provider']).first
     if authentication
       flash[:notice] = "Signed in successfully."
       sign_in_and_redirect(:user, authentication.user)
     elsif current_user
       current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
       flash[:notice] = "Authentication successful."
       redirect_to authentications_url
     else
       user = User.new
       user.apply_omniauth(omniauth)
       puts "=============#{user.authentication[0].provider}"
       if user.save
          puts "=============#{user.authentication[0].provider}"
           puts "=============#{user.email}"
            puts "=============#{authentication[0].user}"
         flash[:notice] = "Created a user successfully."
         sign_in_and_redirect(:user, user)
       else
         session[:omniauth] = omniauth.except('extra')
         redirect_to new_user_registration_url
       end
     end
  end
   

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
     flash[:notice] = params[:message]
    redirect_to root_url, alert: "Authentication failed, please try again."
  end

end
