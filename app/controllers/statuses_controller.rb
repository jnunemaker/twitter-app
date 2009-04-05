class StatusesController < ApplicationController
  before_filter :authenticate
  before_filter :ensure_authorized
  
  def index
    params[:page] ||= 1
    @tweets = current_user.client.friends_timeline(:page => params[:page])
  end
  
  def replies
    params[:page] ||= 1
    @replies = current_user.client.replies(:page => params[:page])
  end
end
