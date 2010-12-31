require 'spec_helper'

describe SessionsController do
  include TwitterStubs

  describe "/create" do
    before do
      stub_oauth_request_token!
    end

    it "should redirect to twitter authorization url" do
      get :create
      
      session['request_token'].should == 't'
      session['request_secret'].should == 's'
      response.location.should =~ /api.twitter.com/
    end
  end
  
  describe "/callback" do
    before do
      stub_oauth_access_token!
      stub_verify_credentials!
    end

    it "should authenticate with twitter" do
      get :callback, :oauth_verifier => 'some_key'
      
      session['access_token'].should == 'at'
      session['access_secret'].should == 'as'
      session[:screen_name].should == 'felipeelias'
      response.should be_redirect
    end
  end
  
  describe "/destroy" do
    it "should logout and destroy all sessions" do
      delete :destroy, :id => "id"
      
      ['access_token', 'access_secret', :screen_name].each do |sess|
        session[sess].should be_nil
      end
    end
  end
end
