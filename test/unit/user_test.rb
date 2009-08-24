# == Schema Information
#
# Table name: users
#
#  id          :integer(4)      not null, primary key
#  email       :string(255)
#  atoken      :string(255)
#  asecret     :string(255)
#  screen_name :string(30)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase  
  should_allow_mass_assignment_of :atoken
  should_allow_mass_assignment_of :asecret
  
  context "authorized?" do
    setup do
      @user = User.new
    end
    
    should "be false if missing atoken and asecret" do
      @user.authorized?.should be(false)
    end
    
    should "be false if missing atoken" do
      @user.atoken = nil
      @user.asecret = 'some secret'
      @user.authorized?.should be(false)
    end
    
    should "be false if missing asecret" do
      @user.atoken = 'some token'
      @user.asecret = nil
      @user.authorized?.should be(false)
    end
    
    should "be true if both atoken and asecret present" do
      @user.atoken = 'some token'
      @user.asecret = 'some secret'
      @user.authorized?.should be(true)
    end
  end
  
  should "have oauth helper" do
    user = User.new
    user.oauth.class.should == Twitter::OAuth
  end
  
  context "twitter client object" do
    setup do
      @user = User.new(:atoken => 'atoken', :asecret => 'asecret')
      @oauth = Twitter::OAuth.new('token', 'secret')
      @user.stubs(:oauth).returns(@oauth)
    end

    should "authorize from access token and secret" do
      @user.expects(:oauth).returns(@oauth)
      @oauth.expects(:authorize_from_access).with('atoken', 'asecret').returns(nil)
      @user.client
    end
    
    should "return twitter base object" do
      @user.client.class.should == Twitter::Base
    end
  end
end
