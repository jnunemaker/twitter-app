class HomeController < ApplicationController
  before_filter :authenticate
  before_filter :ensure_authorized
  
  def index
    params[:page] ||= 1
    @tweets = current_user.client.friends_timeline(:page => params[:page])
    
    params[:older] = params[:page].to_i + 1
    params[:newer] = params[:page].to_i - 1
  end
end
