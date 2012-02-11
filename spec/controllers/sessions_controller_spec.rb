require 'spec_helper'

describe SessionsController do
  render_views
  
  describe "POST 'create'" do
    
    describe "failure" do
      
      before do 
        
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:github] 
      end

      # it "sets a session variable to the OmniAuth auth hash" do
      #   controller.session[:auth_hash]['uid'].should == '123545'
      # end
      
      it "should create authentication" do
        post :create, :provider => "github"
        response.should redirect_to(root_url)
      end
  
    end
  end
end