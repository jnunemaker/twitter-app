class StatusesController < ApplicationController
  before_filter :authenticate
  
  def index
    params[:page] ||= 1
    @tweets = current_user.client.friends_timeline(:page => params[:page])
  end
  
  def mentions
    params[:page] ||= 1
    @mentions = current_user.client.replies(:page => params[:page])
  end
  
  def favorites
    params[:page] ||= 1
    @favorites = current_user.client.favorites(:page => params[:page])
  end
  
  def create
    options = {}
    
    unless params[:in_reply_to_status_id].blank?
      options.merge!({:in_reply_to_status_id => params[:in_reply_to_status_id]})
    end
    
    tweet = current_user.client.update(params[:text], options)
    flash[:notice] = "Got it! Tweet ##{tweet.id} created."
    redirect_to root_url
  end
end
