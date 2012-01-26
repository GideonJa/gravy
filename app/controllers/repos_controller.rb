class ReposController < ApplicationController
  

  def list
    # client = Octokit::Client.new(:login => "gideonja", :password => "-----") # XXX must remove temporary!!!
    token = session[:omniauth][:credentials][:token]
    puts token
    client = Octokit::Client.new(:login => "me", :oauth_token => token)
    @projects = client.list_repositories

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

end
