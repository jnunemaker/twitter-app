class UsersController < ApplicationController
  layout :decide_layout
  
  include Clearance::App::Controllers::UsersController
  
  def show
    @tweets = current_user.client.user_timeline(:id => params[:id])
    
    @user = @tweets.size > 0 ? 
              @tweets.first.user : 
              current_user.client.user(params[:id])
  end
  
  private
    def decide_layout
      %w(new create).include?(action_name) ? 'login' : 'application'
    end
end