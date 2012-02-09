class ProjectsController < ApplicationController

  def index
    @projects =[]
    if current_user
      token = session[:omniauth][:credentials][:token]
      client = Octokit::Client.new(:login => "me", :oauth_token => token)
      @projects = client.list_repositories
    end
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end


  # PUT /projects/1
  # PUT /projects/1.json

end
