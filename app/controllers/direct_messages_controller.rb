class DirectMessagesController < ApplicationController
  before_filter :authenticate
  before_filter :ensure_authorized
  
  def index
    params[:page] ||= 1
    @direct_messages = current_user.client.direct_messages(:page => params[:page])
  end
end
