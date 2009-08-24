# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Twitter::AuthenticationHelpers
  
  layout :determine_layout
  helper :all
  
  protect_from_forgery
  filter_parameter_logging :password, :password_confirmation
  
  rescue_from Twitter::Unauthorized, :with => :initiate_oauth_request
  
  private
    def initiate_oauth_request(exception)
      redirect_to new_authorization_url
    end    
    
    def determine_layout
      signed_in? ? 'application' : 'login'
    end
end
