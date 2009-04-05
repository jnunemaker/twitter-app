class PasswordsController < ApplicationController
  layout 'login'
  
  include Clearance::App::Controllers::PasswordsController
end
