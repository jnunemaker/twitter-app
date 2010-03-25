# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Twitter::AuthenticationHelpers

  helper :all
  protect_from_forgery
  rescue_from Twitter::Unauthorized, :with => :force_sign_in

  private
    def oauth
      @oauth ||= Twitter::OAuth.new(ConsumerConfig['token'], ConsumerConfig['secret'], :sign_in => true)
    end

    def client
      oauth.authorize_from_access(session[:atoken], session[:asecret])
      Twitter::Base.new(oauth)
    end
    helper_method :client

    def force_sign_in(exception)
      reset_session
      flash[:error] = 'Seems your credentials are not good anymore. Please sign in again.'
      redirect_to new_session_path
    end
end
