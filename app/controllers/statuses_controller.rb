class StatusesController < ApplicationController
  before_filter :authenticate

  def index
    params[:page] ||= 1
    @tweets = client.friends_timeline(:page => params[:page])
  end

  def show
    @tweet = client.status(params[:id])
  end

  def mentions
    params[:page] ||= 1
    @mentions = client.replies(:page => params[:page])
  end

  def favorites
    params[:page] ||= 1
    @favorites = client.favorites(:page => params[:page])
  end

  def create
    options = {}
    options.update(:in_reply_to_status_id => params[:in_reply_to_status_id]) if params[:in_reply_to_status_id].present?

    tweet = client.update(params[:text], options)
    flash[:notice] = "Got it! Tweet ##{tweet.id} created."
    return_to_or root_url
  end

  def fav
    flash[:notice] = "Tweet fav'd. May not show up right away due to API latency."
    client.favorite_create(params[:id])
    return_to_or root_url
  end

  def unfav
    flash[:notice] = "Tweet unfav'd. May not show up right away due to API latency."
    client.favorite_destroy(params[:id])
    return_to_or root_url
  end
end
