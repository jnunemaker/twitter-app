# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Twitter::AuthenticationHelpers
  
  helper :all
  protect_from_forgery
  filter_parameter_logging :password, :password_confirmation
  
  rescue_from Twitter::Unauthorized, :with => :force_sign_in
  
  private
    def force_sign_in(exception)
      reset_session
      flash[:error] = 'Seems your credentials are not good anymore. Please sign in again.'
      redirect_to new_session_path
    end
end
