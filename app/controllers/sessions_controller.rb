class SessionsController < ApplicationController

  def create
    # raise request.env["omniauth.auth"].to_yaml
    omniauth = request.env["omniauth.auth"]
   
    # authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    user = User.where(:uid => omniauth['uid'], :provider => omniauth['provider']).first || 
           User.create_with_omniauth(omniauth)
    puts omniauth["info"]["email"]
    session[:user_id] = user.id 
    session[:omniauth] = omniauth.except('extra')  

    redirect_to root_url, :notice => "Signed in successfully!"
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
