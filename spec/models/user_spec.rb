require 'spec_helper'

describe User do

  before(:each) do
    @attr = { 
      :name => "Example User",
      :email => "user@example.com",
      :uid => "2",
      :provider => "twitter"
    }
  end

  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end
  
  it "should require a provider" do
    no_name_user = User.new(@attr.merge(:provider => ""))
    no_name_user.should_not be_valid
  end

  it "should require a uid" do
    no_name_user = User.new(@attr.merge(:uid => ""))
    no_name_user.should_not be_valid
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end


end