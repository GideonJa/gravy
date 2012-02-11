class SessionsController < ApplicationController

  def create
    
    # raise request.env["omniauth.auth"].to_yaml
    omniauth = request.env["omniauth.auth"]
   
    user = User.where(:uid => omniauth['uid'], :provider => omniauth['provider']).first || 
           User.create_with_omniauth(omniauth)
    # Rails.logger.debug "=======================GKJ: user #{user}"
    if user
      session[:user_id] = user.id 
      session[:omniauth] = omniauth.except('extra')  
      redirect_to root_url, :notice => "Signed in successfully!"
      else redirect_to auth_failure_path
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
