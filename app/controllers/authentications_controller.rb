class AuthenticationsController < ApplicationController
  def index
  end

  def create
    omniauth = request.env["omniauth.auth"]
     authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
     gem
     if authentication
       flash[:notice] = "Signed in successfully."
       sign_in_and_redirect(:user, authentication.user)
     elsif current_user
       current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
       flash[:notice] = "Authentication successful."
       redirect_to authentications_url
     else
       user = User.new
       if user.save
         flash[:notice] = "Signed in successfully."
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
