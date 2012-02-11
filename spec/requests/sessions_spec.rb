require 'spec_helper'

  
  describe "signup" do

    describe "success" do
      it "should not make a new user" do
        # TThis example is flawed and only work for returning users. 
        # For new users you'd have to type in password?
        lambda do
          visit root_path
          click_on 'Sign in with GitHub'
          response.should render_template('users/new')
          response.should have_selector(:content => "successfully!")
          response.should render_template('projects/index')
        end
      end
    end
  end
