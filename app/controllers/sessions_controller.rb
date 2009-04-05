class SessionsController < ApplicationController
  layout 'login'
  
  include Clearance::App::Controllers::SessionsController
end
