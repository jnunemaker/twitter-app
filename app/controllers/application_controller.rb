# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Clearance::App::Controllers::ApplicationController
  helper :all
  protect_from_forgery
  
  filter_parameter_logging :password, :password_confirmation
  
  private
    def ensure_authorized
      redirect_to new_authorization_url unless current_user.authorized?
    end
end
