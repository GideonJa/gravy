require 'spec_helper'

describe AuthenticationsController do
   include Devise::TestHelpers

   before (:each) do
     @user = Factory.create(:user)
     sign_in @user
   end

   describe "GET 'index'" do
     it "should be successful" do
       get 'index'
       response.should be_success
     end
   end

end