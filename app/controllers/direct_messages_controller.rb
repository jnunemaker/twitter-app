class DirectMessagesController < ApplicationController
  before_filter :authenticate
  
  def index
    params[:page] ||= 1
    @direct_messages = client.direct_messages(:page => params[:page])
  end
end
