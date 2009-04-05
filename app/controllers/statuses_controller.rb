class StatusesController < ApplicationController
  before_filter :authenticate
  before_filter :ensure_authorized
  
  def index
    params[:page] ||= 1
    @tweets = current_user.client.friends_timeline(:page => params[:page])
  end
  
  def mentions
    params[:page] ||= 1
    @mentions = current_user.client.replies(:page => params[:page])
  end
end
