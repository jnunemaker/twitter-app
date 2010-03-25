module Twitter
  module AuthenticationHelpers
    def self.included(controller)
      controller.send :include, InstanceMethods

      controller.class_eval do
        helper_method :current_user
        helper_method :signed_in?

        hide_action :current_user, :signed_in?
      end
    end

    module InstanceMethods
      def signed_in?
        !session[:screen_name].nil?
      end

      protected
        def authenticate
          deny_access unless signed_in?
        end

        def sign_in(profile)
          session[:screen_name] = profile.screen_name if profile
        end

        def redirect_back_or(default)
          session[:return_to] ||= params[:return_to]
          if session[:return_to]
            redirect_to(session[:return_to])
          else
            redirect_to(default)
          end
          session[:return_to] = nil
        end

        def redirect_to_root
          redirect_to root_url
        end

        def store_location
          session[:return_to] = request.request_uri if request.get?
        end

        def deny_access(flash_message = nil, opts = {})
          store_location
          flash[:failure] = flash_message if flash_message
          render :template => "/sessions/new", :status => :unauthorized
        end
    end
  end
end