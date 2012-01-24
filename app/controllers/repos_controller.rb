class ReposController < ApplicationController
  

  def list
    client = Octokit::Client.new(:login => "gideonja", :password => "-----") # XXX must remove temporary!!!
    @projects = client.list_repositories

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

end
